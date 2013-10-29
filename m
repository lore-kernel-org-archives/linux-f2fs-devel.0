From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev 3/5] f2fs: Add a new function: f2fs_reserve_block()
Date: Tue, 29 Oct 2013 09:56:10 +0900
Message-ID: <1383008170.14041.0.camel@kjgkr>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
 <1382716919-23345-4-git-send-email-huajun.li.lee@gmail.com>
 <1382962607.992.104.camel@kjgkr> <1382963296.992.108.camel@kjgkr>
 <CA+v9cxYx35Q=PS4wB52JSWj75T9xg_VYp9PySujZNhPWxj9jAA@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CA+v9cxYx35Q=PS4wB52JSWj75T9xg_VYp9PySujZNhPWxj9jAA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

2013-10-29 (=ED=99=94), 00:53 +0800, Huajun Li:
> Hi Jaegeuk,
>=20
> Thanks for your kindly review and comments.
>=20
> On Mon, Oct 28, 2013 at 8:28 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com=
> wrote:
> > 2013-10-28 (=EC=9B=94), 21:16 +0900, Jaegeuk Kim:
> > Hi,
> >
> >>
> >> 2013-10-26 (=ED=86=A0), 00:01 +0800, Huajun Li:
> >> > From: Huajun Li <huajun.li@intel.com>
> >> >
> >> > Add the function f2fs_reserve_block() to easily reserve new bloc=
ks.
> >> >
> >> > Signed-off-by: Huajun Li <huajun.li@intel.com>
> >> > Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
> >> > Signed-off-by: Weihong Xu <weihong.xu@intel.com>
> >> > ---
> >> >  fs/f2fs/data.c |   29 ++++++++++++++++++-----------
> >> >  fs/f2fs/f2fs.h |    1 +
> >> >  2 files changed, 19 insertions(+), 11 deletions(-)
> >> >
> >> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> > index c8887d8..7b31911 100644
> >> > --- a/fs/f2fs/data.c
> >> > +++ b/fs/f2fs/data.c
> >> > @@ -64,6 +64,23 @@ int reserve_new_block(struct dnode_of_data *d=
n)
> >> >     return 0;
> >> >  }
> >> >
> >> > +int f2fs_reserve_block(struct inode *inode,
> >> > +                  struct dnode_of_data *dn, pgoff_t index)
> >>
> >
> > We don't need to get dnode_of_data from parameters, since it is
> > used by this function only.
>=20
> After calling f2fs_reserve_block(), we need dn.data_blkaddr to check
> whether it is NEW_ADDR. So IMO, it's nice to keep this parameter.
>=20

Ah, got it.
BTW, I found another flows we can clean up wrt this issue.
How about this?

---
 fs/f2fs/data.c | 51 +++++++++++++++++++++++---------------------------=
-
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 39 ++++++---------------------------------
 3 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c8887d8..b8c4f76d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -64,6 +64,22 @@ int reserve_new_block(struct dnode_of_data *dn)
        return 0;
 }
=20
+int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
+{
+       bool need_put =3D dn->inode_page ? false : true;
+       int err;
+
+       err =3D get_dnode_of_data(dn, index, ALLOC_NODE);
+       if (err)
+               return err;
+       if (dn->data_blkaddr =3D=3D NULL_ADDR)
+               err =3D reserve_new_block(dn);
+
+       if (need_put)
+               f2fs_put_dnode(dn);
+       return err;
+}
+
 static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
                                        struct buffer_head *bh_result)
 {
@@ -300,19 +316,9 @@ struct page *get_new_data_page(struct inode *inode=
,
        int err;
=20
        set_new_dnode(&dn, inode, npage, npage, 0);
-       err =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
+       err =3D f2fs_reserve_block(&dn, index);
        if (err)
                return ERR_PTR(err);
-
-       if (dn.data_blkaddr =3D=3D NULL_ADDR) {
-               if (reserve_new_block(&dn)) {
-                       if (!npage)
-                               f2fs_put_dnode(&dn);
-                       return ERR_PTR(-ENOSPC);
-               }
-       }
-       if (!npage)
-               f2fs_put_dnode(&dn);
 repeat:
        page =3D grab_cache_page(mapping, index);
        if (!page)
@@ -644,21 +650,15 @@ repeat:
        *pagep =3D page;
=20
        f2fs_lock_op(sbi);
-
        set_new_dnode(&dn, inode, NULL, NULL, 0);
-       err =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
-       if (err)
-               goto err;
-
-       if (dn.data_blkaddr =3D=3D NULL_ADDR)
-               err =3D reserve_new_block(&dn);
-
-       f2fs_put_dnode(&dn);
-       if (err)
-               goto err;
-
+       err =3D f2fs_reserve_block(&dn, index);
        f2fs_unlock_op(sbi);
=20
+       if (err) {
+               f2fs_put_page(page, 1);
+               return err;
+       }
+
        if ((len =3D=3D PAGE_CACHE_SIZE) || PageUptodate(page))
                return 0;
=20
@@ -691,11 +691,6 @@ out:
        SetPageUptodate(page);
        clear_cold_data(page);
        return 0;
-
-err:
-       f2fs_unlock_op(sbi);
-       f2fs_put_page(page, 1);
-       return err;
 }
=20
 static int f2fs_write_end(struct file *file,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c9d394c..e77ca20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1112,6 +1112,7 @@ void destroy_checkpoint_caches(void);
  * data.c
  */
 int reserve_new_block(struct dnode_of_data *);
+int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 void update_extent_cache(block_t, struct dnode_of_data *);
 struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2d4190a..21ef0d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -33,7 +33,6 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct
*vma,
        struct page *page =3D vmf->page;
        struct inode *inode =3D file_inode(vma->vm_file);
        struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
-       block_t old_blk_addr;
        struct dnode_of_data dn;
        int err;
=20
@@ -44,24 +43,10 @@ static int f2fs_vm_page_mkwrite(struct
vm_area_struct *vma,
        /* block allocation */
        f2fs_lock_op(sbi);
        set_new_dnode(&dn, inode, NULL, NULL, 0);
-       err =3D get_dnode_of_data(&dn, page->index, ALLOC_NODE);
-       if (err) {
-               f2fs_unlock_op(sbi);
-               goto out;
-       }
-
-       old_blk_addr =3D dn.data_blkaddr;
-
-       if (old_blk_addr =3D=3D NULL_ADDR) {
-               err =3D reserve_new_block(&dn);
-               if (err) {
-                       f2fs_put_dnode(&dn);
-                       f2fs_unlock_op(sbi);
-                       goto out;
-               }
-       }
-       f2fs_put_dnode(&dn);
+       err =3D f2fs_reserve_block(&dn, page->index);
        f2fs_unlock_op(sbi);
+       if (err)
+               goto out;
=20
        file_update_time(vma->vm_file);
        lock_page(page);
@@ -531,22 +516,10 @@ static int expand_inode_data(struct inode *inode,
loff_t offset,
=20
                f2fs_lock_op(sbi);
                set_new_dnode(&dn, inode, NULL, NULL, 0);
-               ret =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
-               if (ret) {
-                       f2fs_unlock_op(sbi);
-                       break;
-               }
-
-               if (dn.data_blkaddr =3D=3D NULL_ADDR) {
-                       ret =3D reserve_new_block(&dn);
-                       if (ret) {
-                               f2fs_put_dnode(&dn);
-                               f2fs_unlock_op(sbi);
-                               break;
-                       }
-               }
-               f2fs_put_dnode(&dn);
+               ret =3D f2fs_reserve_block(&dn, index);
                f2fs_unlock_op(sbi);
+               if (ret)
+                       break;
=20
                if (pg_start =3D=3D pg_end)
                        new_size =3D offset + len;
--=20
1.8.4.474.g128a96c

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
