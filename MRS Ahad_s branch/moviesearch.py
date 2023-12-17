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

def main():
    st.title("Movie Search App")

    # Input for movie search
    search_query = st.text_input("Enter a movie name:", "Toy Story")

    if st.button("Search"):
        # Fetch movie data based on the search query
        movie_results = fetch_movie_data(search_query)

        # Display movies in 2 rows with 3 columns each
        columns = st.columns(3)  # 3 columns for each row

        for i, movie in enumerate(movie_results):
            title = movie.get("title")
            poster_path = movie.get("poster_path")

            # Construct the full URL for the poster image
            if poster_path:
                poster_url = f"https://image.tmdb.org/t/p/w300/{poster_path}"  # Adjusted poster size
            else:
                z

            # Display movie information in respective columns
            with columns[i % 3]:
                st.subheader(title)
                st.image(poster_url, caption=title, use_column_width=True)

if __name__ == "__main__":
    main()
