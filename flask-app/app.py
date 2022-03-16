from flask import Flask, render_template
import random
app = Flask(__name__)
# list of cat images
images = [
"https://media.istockphoto.com/photos/grey-cat-lying-on-bed-picture-id1082353380?s=612x612",
"https://media.istockphoto.com/photos/mink-bengal-relaxing-outdoor-picture-id1019867458?s=612x612",
"https://cdn.pixabay.com/photo/2014/04/05/12/24/cat-316985_960_720.jpg",
"https://cdn.pixabay.com/photo/2017/11/23/15/34/kitten-2973049_960_720.jpg",
"https://cdn.pixabay.com/photo/2015/06/09/09/35/animal-children-803123_960_720.jpg",
"https://cdn.pixabay.com/photo/2017/06/29/10/22/folded-ears-2453763_960_720.jpg"]
@app.route('/')
def index():
  url = random.choice(images)
  return render_template('index.html', url=url)
if __name__ == "__main__":
 app.run(host = "0.0.0.0")
