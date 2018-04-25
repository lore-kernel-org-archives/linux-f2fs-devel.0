From: Jayashree Mohan <jayashree2912@gmail.com>
Subject: Re: Lack of strictly ordered metadata crash recovery in
 f2fs
Date: Wed, 25 Apr 2018 06:15:18 -0500
Message-ID: <CA+EzBbAFSTzbL5aneXqQW9ewYhRUxQGqXN0f+PXGnngW9u7Jfw@mail.gmail.com>
References: <CA+EzBbCxHTeuNWU5M3wrtyYBmpcjgUGbfkNKysX5iVKivg6u3A@mail.gmail.com>
 <20180425044825.GA91652@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jayashree2912@gmail.com>) id 1fBIOU-0003hK-Ra
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 11:15:26 +0000
Received: from mail-vk0-f49.google.com ([209.85.213.49])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fBIOT-00BNI4-9R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 11:15:26 +0000
Received: by mail-vk0-f49.google.com with SMTP id q189so13576370vkb.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Apr 2018 04:15:25 -0700 (PDT)
In-Reply-To: <20180425044825.GA91652@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Thanks for the quick reply!

On Tue, Apr 24, 2018 at 11:48 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi,
>
> On 04/24, Jayashree Mohan wrote:
> > Hi,
> >
> > While testing filesystems for crash consistency, we came across a
> > workload that could demonstrate that f2fs lacks strictly ordered
> > metadata behavior.
> >
> > Workload:
> >
> > mkdir A
> > sync()
> > rename(A, B)
> > creat (B/foo)
> > fsync (B/foo)
> > ---crash---
> >
> > For a strictly ordered metadata filesystem, if we fsync a file, then
> > all previous transactions that are required to reference this file
> > must also be committed. Going by this logic, fsync(B/foo) should have
> > persisted the rename operation and the directory B itself. ext4 and
> > xfs correctly resolve all dependencies and on recovery from a crash,
> > we see both directory B and B/foo i.e. the contents of directory are:
> > dir A : does not exist
> > dir B:
> >     foo
> >
> > However in f2fs, on recovery we see:
> > dir A :
> >     foo
> > dir B : does not exist
>
> Since we recover foo based on its parent inode number, not based on
> its path.


Okay, that explains why foo gets into dir A.

>
>
> >
> > This seems to be an incorrect state to recover to, because the file
> > foo was created in directory B after the rename operation and we
> > incorrectly see the entry in directory A.
>
> Then, user needs to do fsync on dir B, in order to guarantee that.
>
> >
> > However, if we tweak the workload to not have a sync, i.e
> > mkdir A
> > rename(A, B)
> > creat (B/foo)
> > fsync (B/foo)
> > ---crash---
> >
> > then, the file B/foo and directory B are persisted. We don't seem to
> > understand the reason for this behaviour.
> >
> > We understand that POSIX requires fsync on directory B to persist the
> > rename operation, and f2fs does persist the entries if we sync the
> > directory, however most filesystems(ext4, xfs) provide much higher
> > guarantees when it comes to crash consistency.
>
> We met the similar issue before, and decided to give a mount option to deal
> with such the need via "-o fsync_mode=strict". And, I think we can enforce
> the stric mode covering to this case as well.


Oh! Did not know about this mount option. This makes sense. We will
make sure to use this mount option while performing any further crash
consistency tests.


>
> From cb0757e203b0bdce9d0b207507425e2f8ea1f392 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 24 Apr 2018 22:43:01 -0600
> Subject: [PATCH] f2fs: enforce fsync_mode=strict for renamed directory
>
> This is to give a option for user to be able to recover B/foo in the below
> case.
>
> mkdir A
> sync()
> rename(A, B)
> creat (B/foo)
> fsync (B/foo)
> ---crash---
>
> Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b5f404674cad..fef6e3ab2135 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>                         f2fs_put_page(old_dir_page, 0);
>                 f2fs_i_links_write(old_dir, false);
>         }
> -       if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +       if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
>                 add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +               if (S_ISDIR(old_inode->i_mode))
> +                       add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
> +       }
>
>         f2fs_unlock_op(sbi);
>
> --


Thanks for the quick patch!
We hope our reports are useful to identify corner cases like these
that have skipped your attention, and fix them up in a timely manner.
Again, thanks for being so responsive.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
