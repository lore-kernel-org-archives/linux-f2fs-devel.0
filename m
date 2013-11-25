From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev][PATCH V2 4/6] f2fs: Key functions to handle inline data
Date: Mon, 25 Nov 2013 20:01:35 +0900
Message-ID: <1385377295.26319.157.camel@kjgkr>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
 <1384096401-25169-5-git-send-email-huajun.li.lee@gmail.com>
 <1384501749.14041.107.camel@kjgkr>
 <CA+v9cxZTJrcYZVoqNcopU3sWwMn2zvde89YfMW=2pK=W1DJYtw@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CA+v9cxZTJrcYZVoqNcopU3sWwMn2zvde89YfMW=2pK=W1DJYtw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

2013-11-20 (=EC=88=98), 20:51 +0800, Huajun Li:
> On Fri, Nov 15, 2013 at 3:49 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com=
> wrote:
> > Hi Huajun,
> >
> > [snip]
> >
> >> +static int __f2fs_convert_inline_data(struct inode *inode, struct=
 page *page)
> >> +{
> >> +     int err;
> >> +     struct page *ipage;
> >> +     struct dnode_of_data dn;
> >> +     void *src_addr, *dst_addr;
> >> +     block_t old_blk_addr, new_blk_addr;
> >> +     struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> >> +
> >> +     f2fs_lock_op(sbi);
> >> +     ipage =3D get_node_page(sbi, inode->i_ino);
> >> +     if (IS_ERR(ipage))
> >> +             return PTR_ERR(ipage);
> >> +
> >> +     /*
> >> +      * i_addr[0] is not used for inline data,
> >> +      * so reserving new block will not destroy inline data
> >> +      */
> >> +     set_new_dnode(&dn, inode, ipage, ipage, 0);
> >> +     err =3D f2fs_reserve_block(&dn, 0);
> >> +     if (err) {
> >> +             f2fs_put_page(ipage, 1);
> >> +             f2fs_unlock_op(sbi);
> >> +             return err;
> >> +     }
> >> +
> >> +     src_addr =3D inline_data_addr(ipage);
> >> +     dst_addr =3D page_address(page);
> >> +     zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> >> +
> >> +     /* Copy the whole inline data block */
> >> +     memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
> >> +
> >> +     /* write data page to try to make data consistent */
> >> +     old_blk_addr =3D dn.data_blkaddr;
> >> +     set_page_writeback(page);
> >> +     write_data_page(inode, page, &dn,
> >> +                     old_blk_addr, &new_blk_addr);
> >> +     update_extent_cache(new_blk_addr, &dn);
> >> +     f2fs_wait_on_page_writeback(page, DATA, true);
> >> +
> >> +     /* clear inline data and flag after data writeback */
> >> +     zero_user_segment(ipage, INLINE_DATA_OFFSET,
> >> +                              INLINE_DATA_OFFSET + MAX_INLINE_DAT=
A);
> >> +     clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
> >> +
> >> +     sync_inode_page(&dn);
> >> +     f2fs_put_page(ipage, 1);
> >
> > Again, it seems that you missed what I mentioned.
> > If we write the inlined data block only, we cannot recover the data
> > block after SPO.
> > In order to avoid that, we should write its dnode block too by
> > triggering sync_node_pages(ino) at this point as similar as fsync
> > routine.
> >
> > Thanks,
> >
> > --
> > Jaegeuk Kim
> > Samsung
> >
>=20
> Hi Jaegeuk,
> Previously, I refactored f2fs_sync_file() and tried to call it while
> converting inline data, but find it is easily dead lock, so just writ=
e
> data block here.
> Then, how about following enhancement to this patch ?  it only copies
> some codes to the end of  __f2fs_convert_inline_data(),  and keeps
> others same as before.

Sorry for the late response.
It takes some time for me to verify the consistency problem in more
detail.

What I've concerned was the following issues:
 - inlined data was synced before or not,
 - inlined data was fsynced before or not,
 - its parent directory inode was synced before or not,
 - recovery can be safe?
 - ...

Most of these issues are based on the question that "can we recover the
inlined data after sudden-power-off safely?".

And initially what I concerned was from the following scenario.
 1. user writes 3KB data
 2. sync or fsync
 3. user writes 4KB data
   : remove direct pointers in the inode page,
       and cache a converted data page.
 4. do checkpoint
   : write the inode page only

 ** After power-cut, user expect at least the file should have 3KB data=
,
but there is no data due to the converted inline data.

Lastly, I found that, it'd be ok if we can cover the following lock
coverages.
  - f2fs_lock_op
  |    - lock_page(inode_page)
  |   |   -- convert_inline_data()
  |   |      1. write_data_page()
  |   |      2. update its inode page()
  |    - unlock_page(inode_page)
  - f2fs_unlock_op

This means that, the step #4 can guarantee that the inode has the direc=
t
pointer of 4KB data.
And when considering other cases, I couldn't find any issues.

So, yes, I concluded that your first approach which writes data pages
only was correct.

However I found that it needs to modify some recovery routine integrate=
d
to your patch, [5/6].

In do_recover_data(inode_page),
 1. get the first file offset of the inode_page,
 2. get its previous written inode page,
 3. diff direct pointers between previous inode page and current inode
page
 4. check previous and current direct pointers

Let's suppose that the previous inode page has inline data and current
inode page is a coverted node page or vice versa.

[direct pointers]    [previous inode page]     [current inode page]
       [0]             abcd (inline data)         xxx (block addr)
or,
       [0]             xxx (block addr)           abcd (inline data)

In this case, f2fs will recover errorneous block addresses, so it needs
to avoid mishandling the direct pointers too.

Thanks,

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
