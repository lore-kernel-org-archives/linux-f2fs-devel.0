From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs updates for v4.6
Date: Thu, 17 Mar 2016 19:32:34 -0700
Message-ID: <CA+55aFxQnvWro5snYgRWu+A557+ZgY2Gxsj4MXmPYS-TOzKBLw@mail.gmail.com>
References: <20160318005803.GA96629@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160318005803.GA96629@jaegeuk.gateway>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Mar 17, 2016 at 5:58 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Note that, I did cherry-pick one patch and add another patch to resolve the
> conflict against recent crypto changes.

*please* don't do things like this!

Now I have a conflict _anyway_, and because you added extra commits it
ends up being just messier. Git notices that you renamed
fs/f2fs/crypto_fname.c into fs/crypto/fname.c, and sees that different
people did different things, so now your "merge resolution" conflicts
with the changes I already merged to the original file from the crypto
tree.

Yes, yes, since you also did that "f2fs: Use skcipher", the resolution
now is to just throw the extra merge resolution away, but it's
literally just messier and more work for me, because it makes even
less sense than it would have done to just do the merge resolution
directly.

I do *not* want maintainers of two different trees trying to resolve
things against each other ahead of time. It makes no sense, and it
makes the history make no sense.

Now, if a merge ends up being really painful, I might ask you to help
resolve a merge, but quite frankly, that is very very rare.

I'd much *much* rather see you just do stuff that makes sense for your
tree. In particular, you really should have done that "move file" as a
single file move commit, and just left it at that. Instead, your tree
does something insane:

 - first it cherry-picks the change from the crypto tree

 - then it *copies* the old file to fs/crypto/fname.c, and changes the
naming to match.

 - at this point nothing actually *uses* the new file or new naming at all.

 - then it "resolves the merge conflict" by re-doing *AGAIN* that
crypto change that it shouldn't have cared about in the first place

 - then it removes the old file and switches to the new naming in the users

That makes no sense what-so-ever.

What would have been *sensible* would have been to split it up in a
*natural* way:

 - move the file to a new subdirectory in one commit (together with
the Makefile/Kconfig stuff that enables it)

 - change the naming to match the new location in another.

or even just do it all in one single step. And at no point worry about
the fact that the crypto tree did something unrelated to your work.

You should aim to make the changes make sense in *your* tree. Not copy
and create files that aren't used until the next stage. Not pre-merge
with another completely unrelated tree.

Now you actually did extra work apparently to "help", but what it
caused was for me to have to try to figure out those crazy steps, and
it made the history just uglier.

And note that even if I didn't have a conflict (git didn't notice that
there were a few other files that moved too, because the renaming made
the file contents too different), I would still have preferred to
simply do the conflict resolution at the time of the merge, rather
than have it pre-done.

Put another way: you doing the "pre-merge" resolution ends up making
my merge simpler from a purely technical standpoint, but it also makes
the history make very little sense. I'd much rather have the history
make sense, and then in the actual *merge* when the f2fs tree really
meets the crypto tree updates, the resolution fixes things up (and
then the resolution makes sense within those confines too).

And never add files that aren't even used. Now we literally have this
insane situation that commit 7690143802f1 ("fs crypto: add crypto.c
for encrypt/decrypt functions") adds a new directory, and a new file
in it, but there is absolutely nothing that references that new file.
So it's all completely empty work.

Then later, you add the Makefile and Kconfig rules to start building
the files, but still nothing *uses* it.

And then, after that, you have one commit that removes the old code,
and switches over to the new code.

Not only does none of this make ANY SENSE WHAT-SO-EVER, but it's a
complete nightmare if something breaks. The point you *notice* that
things break is when you switch over the new code, but that isn't
actually when the new code happens, so now you have this situation
where the commit that introduces the breakage basically silently
introduces all that old code that was never actually used - but it's
not shown in that commit!

This is why I think you should have just renamed the files one by one,
and actually started using them as you go along. See? Not only would
it make more sense, but when a problem happens, you actually see what
causes it, instead of it being a "oh, we switched over to that
completely different code that had never been used by anything at all
before".

                 Linus
