From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: update file name in the inode block during
 f2fs_rename
Date: Mon, 22 Jul 2013 22:24:46 +0900
Message-ID: <1374499486.26443.39.camel@kjgkr>
References: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
 <20130718092211.GA4165@ZenIV.linux.org.uk>
 <CAOtxgyetWtucBEQJmCU0nLNk9_r42yQSC1+X1i+iHM18rDge+Q@mail.gmail.com>
 <20130719074937.GD4165@ZenIV.linux.org.uk>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20130719074937.GD4165@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Kim Jaegeuk <jaegeuk.kim@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Al,

2013-07-19 (=EA=B8=88), 08:49 +0100, Al Viro:
> On Fri, Jul 19, 2013 at 12:40:47PM +0900, Kim Jaegeuk wrote:
> > Hi,
> >=20
> > 2013. 7. 18. ???? 6:22?? "Al Viro" <viro@zeniv.linux.org.uk>???? ??=
??:
> > >
> > > On Thu, Jul 18, 2013 at 06:11:23PM +0900, Jaegeuk Kim wrote:
> > > > The error is reproducible by:
> > > >
> > > > After this, when we retrieve the inode->i_name of test2 by dump=
=2Ef2fs,
> > we get
> > > > test1 instead of test2.
> > > > This is because f2fs didn't update the file name during the f2f=
s_rename.
> > >
> > > Er...  Correct me if I'm wrong, but f2fs appears to support link(=
2) and
> > > if rename(2) creates some problem for dump.f2fs, I would expect a=
n
> > > equivalent link()+unlink() combination to do the same...
> >=20
> > Right. I will check that too.
> > Thank you. :)
>=20
> You do realize that having unlink() hunt for the surviving links woul=
d be
> both very costly and painful wrt locking, right?

What I meant that I need to check f2fs_sync_file() to deal with the
link() + unlink() combination case.

>=20
> The real question is, what are the warranties for that ->i_name thing=
?
> What should it be while there are multiple links?  Matter of fact,
> after looking at the users... What about ->i_pino in the same scenari=
o
> (link+unlink instead of rename)?

The only usage of both i_name and i_pino is for the roll-forward
recovery.=20

Let me give a scenario like this.
1. create "file a"
2. fsync "file a"
  -> At this moment, in order to recover "file a", naive f2fs needs to
conduct costly checkpoint to flush all the dentry blocks.

But, in the roll-forward machinism with a dentry recovery routine,
1. create "file a"
2. fsync "file a"
  -> The f2fs stores i_name as "file a" and its i_pino so that
recover_dentry() can add link again with "file a" under i_pino.

But, there are some creteria like:
1. link_count should be one, and
2. its i_name should be correct.

But, I think i_pino is correctly fixed at f2fs_sync_file() even if ther=
e
have been experienced link() + unlink() combinations before.
But, i_name should have to be fixed too not just for f2fs_rename().
This is what I concerned before.

>=20
> BTW, while looking at i_pino... Why does get_parent_ino() bother with
> igrab/iput?  If you have found an alias, just use parent_ino(dentry)
> and be done with that - as it is, you have a race with d_move() there=
,
> so you'd need to reproduce parent_ino() locking anyway (->d_lock on
> dentry holds d_move() away and stabilizes ->d_parent->d_inode)

Oh, I didn't realize that.
I'll fix like that.
Thanks,

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
