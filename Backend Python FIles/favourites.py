import requests
import streamlit as st

def fetch_movie_data(query):
    url = "https://api.themoviedb.org/3/search/movie"
    params = {
        "query": query,
        "include_adult": False,
        "language": "en-US",
        "page": 1
    }

    headers = {
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjY2ExNWU2NmQ3MjkxMzgwZDM1OGVmN2QwNDUzZmJkYSIsInN1YiI6IjY1MmY3MWI1YTgwMjM2MDExYWM3ZjdkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.H4ghrO6r_x9XY5-IdO_SUU4M2TMUM1RPO2PPsVZoiNs"  # Replace with your TMDb API key
    }

    response = requests.get(url, params=params, headers=headers)

    if response.status_code == 200:
        return response.json().get("results", [])
    else:
        st.error(f"Error: {response.status_code}")
        st.stop()

def fetch_movie_recommendations(movie_id):
    url = f"https://api.themoviedb.org/3/movie/{movie_id}/recommendations"
    
    params = {
        "language": "en-US",
        "page": 1
    }

    headers = {
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjY2ExNWU2NmQ3MjkxMzgwZDM1OGVmN2QwNDUzZmJkYSIsInN1YiI6IjY1MmY3MWI1YTgwMjM2MDExYWM3ZjdkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.H4ghrO6r_x9XY5-IdO_SUU4M2TMUM1RPO2PPsVZoiNs"  # Replace with your TMDb API key
    }

    response = requests.get(url, params=params, headers=headers)

    if response.status_code == 200:
        return response.json().get("results", [])
    else:
        st.error(f"Error: {response.status_code}")
        st.stop()

def main():
    st.title("Movie Recommendation App")

    # Initialize session state
    if 'search_results' not in st.session_state:
        st.session_state.search_results = []

    if 'recommendations' not in st.session_state:
        st.session_state.recommendations = []

    if 'favorites' not in st.session_state:
        st.session_state.favorites = []

    # Check if recommendations are being viewed
    if st.session_state.recommendations:
        st.title("Recommended Movies")

        # Display recommended movies
        columns_rec = st.columns(3)  # 3 columns for each row

        for i, recommendation in enumerate(st.session_state.recommendations):
            recommended_title = recommendation.get("title")
            recommended_poster_path = recommendation.get("poster_path")

            # Construct the full URL for the poster image
            if recommended_poster_path:
                recommended_poster_url = f"https://image.tmdb.org/t/p/w300/{recommended_poster_path}"  # Adjusted poster size
            else:
                recommended_poster_url = "https://via.placeholder.com/300x450"

            # Display recommended movie information in respective columns
            with columns_rec[i % 3]:
                st.subheader(recommended_title)
                st.image(recommended_poster_url, caption=recommended_title, use_column_width=True)

        # Button to go back to the search screen
        if st.button("Back to Search"):
            st.session_state.recommendations = []  # Clear recommendations
    else:
        # Input for movie search
        search_query = st.text_input("Enter a movie name:", "Toy Story")

        if st.button("Search"):
            # Fetch movie data based on the search query
            st.session_state.search_results = fetch_movie_data(search_query)

            if not st.session_state.search_results:
                st.warning("No results found. Please try a different query.")
                st.stop()

        # Display movies in 2 rows with 3 columns each
        columns = st.columns(3)  # 3 columns for each row

        for i, movie in enumerate(st.session_state.search_results):
            title = movie.get("title")
            poster_path = movie.get("poster_path")
            movie_id = movie.get("id")

            # Construct the full URL for the poster image
            if poster_path:
                poster_url = f"https://image.tmdb.org/t/p/w300/{poster_path}"  # Adjusted poster size
            else:
                poster_url = "https://via.placeholder.com/300x450"

            # Display movie information in respective columns
            with columns[i % 3]:
                st.subheader(title)
                st.image(poster_url, caption=title, use_column_width=True)

                # Recommendation button with a unique key
                button_key = f"recommend_button_{movie_id}"
                if st.button("Get Recommendations", key=button_key):
                    recommendations = fetch_movie_recommendations(movie_id)
                    st.session_state.recommendations = recommendations  # Store recommendations
                    st.experimental_rerun()  # Rerun the script to show recommendations

                # Add to favorites button
                add_to_favorites_key = f"add_to_favorites_button_{movie_id}"
                if st.button("Add to Favorites", key=add_to_favorites_key):
                    st.session_state.favorites.append(movie)
                    st.success(f"{title} added to favorites!")

        # Button to view favorites
        if st.button("View Favorites"):
            st.title("Favorites")
            columns_fav = st.columns(3)  # 3 columns for each row

            for i, favorite in enumerate(st.session_state.favorites):
                fav_title = favorite.get("title")
                fav_poster_path = favorite.get("poster_path")

                # Construct the full URL for the poster image
                if fav_poster_path:
                    fav_poster_url = f"https://image.tmdb.org/t/p/w300/{fav_poster_path}"  # Adjusted poster size
                else:
                    fav_poster_url = "https://via.placeholder.com/300x450"

                # Display favorite movie information in respective columns
                with columns_fav[i % 3]:
                    st.subheader(fav_title)
                    st.image(fav_poster_url, caption=fav_title, use_column_width=True)

if __name__ == "__main__":
    main()
