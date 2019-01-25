From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Proposal: A new fs-verity interface
Date: Fri, 25 Jan 2019 13:35:05 +1300
Message-ID: <CAHk-=wjw+tAKu7fM3GwUX9i7LBFuvB=ohqXj+KgQQaW3pCzfxg@mail.gmail.com>
References: <20190110051500.GA32361@mit.edu> <20190114234101.GQ27534@dastard>
 <20190123051017.GA8785@mit.edu> <20190124212544.GS6173@dastard>
 <CAHk-=wh7jq6U3+ou_FDujB-ipg9JcJAGSjEQ_niCwLG313x6UA@mail.gmail.com>
 <20190124232237.GH8785@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <torvalds@linuxfoundation.org>) id 1gmpT9-0000ak-Ka
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 00:35:39 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gmpT1-00GWUX-9O
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Jan 2019 00:35:39 +0000
Received: by mail-lj1-f179.google.com with SMTP id k15-v6so6892176ljc.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Jan 2019 16:35:30 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id z7-v6sm1230345lji.42.2019.01.24.16.35.22
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 16:35:22 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id u18so5685245lff.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Jan 2019 16:35:22 -0800 (PST)
In-Reply-To: <20190124232237.GH8785@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org

On Fri, Jan 25, 2019 at 12:22 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
>
> > I understand that you don't want to load the whole merkle tree into
> > memory, and that is the reason that you want to point to some "stable
> > on disk" area, but the hole punching does seem to be a particularly
> > nasty part of it. It would be much better to have the merkle data in
> > some place where it doesn't then need to be hidden again, no?
>
> It's not really a "hole punch", but we are moving the data around.
> That's because Dave Chinner and Christoph demanded it.  The original
> approach was to put it at the end of the file, and then hide it.  If
> the question is "why hide the metadata", it's because it's metadata.
> We certainly don't want to make it be visible as part of the file
> stream.

But that's the whole hiding thing. Why do you feel you need to do
that? Why not just leave it alone, and leave it visible, and say "hey,
the merkle data for file X comes from here".

Punching a hole, or moving it somewhere else, or hiding or, or
whatever you want to do, all mean "you have to modify the filesystem".
They also mean "you can't back up the original sanely any more and
move it somewhere else".

Wouldn't it be much nicer to simple have a *separate* stream. If it's
not an xattr, then maybe just a separate file entirely. A file that
just contains the merkle data, and has no alignment things because
there's no "it's at the end of the file that it describes" issues,
it's just a standalone thing that is still visible so that you can
copy the original data and it's still valid (even if the merkle tree
then isn't _enabled_ in the copy, but now you could re-enable it in a
new location).

> We could store the metadata somewhere else --- for example, we could
> store it in another inode.  But inodes have overhead, and that would
> mean using two inodes for every fs-verity protected files --- and we
> don't need all of the other metadata (mtime, ctime, etc.) for the
> Merkle tree.

Well, if one of the issues is that the merkle data ends up being
megabytes, I don't see this as being  a huge issue. Particularly since
the alignemnt restrictions in the unified thing means that you still
aren't exactly "packing" the merkle data efficiently to begin with..

In fact, if you want to have merkle data for small files (where the
merkle data itself is just a  few words), then having it in a separate
file and as part of the inode inline data doesn't seem like it's
likely any worse (and might be *better*) than having it at some block
boundary due to alignment...

Hmm?

            Linus
