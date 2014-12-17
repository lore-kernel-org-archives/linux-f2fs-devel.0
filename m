From: Changman Lee <cm224.lee@gmail.com>
Subject: Re: [PATCH v2] f2fs: use ra_meta_pages to simplify
 readahead code in restore_node_summary
Date: Thu, 18 Dec 2014 00:19:56 +0900
Message-ID: <CAN863PuF-aSNGxe6=5k9LL-9V5maHnNnd7w-Sz2GQPFz-MHC7A@mail.gmail.com>
References: <001d01d019e1$d6ad6c10$84084430$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@gmail.com>) id 1Y1GOT-0007Pm-9H
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Dec 2014 15:20:05 +0000
Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Y1GOR-0005F0-CF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Dec 2014 15:20:05 +0000
Received: by mail-lb0-f182.google.com with SMTP id f15so13767850lbj.41
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2014 07:19:57 -0800 (PST)
In-Reply-To: <001d01d019e1$d6ad6c10$84084430$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi,

Is there any reason to use truncate_inode_pages_range instead of
invalidate_mapping_pages?
IMHO, it seems nice to just use invalidate_mapping_pages because pages
of meta_inode shouldn't be dirty, locked, under writeback or mapped in
this function.
If there is my misunderstanding, let me know.

Thanks,

Reviewed-by: Changman Lee <cm224.lee@samsung.com>

2014-12-17 19:10 GMT+09:00 Chao Yu <chao2.yu@samsung.com>:
> Use more common function ra_meta_pages() with META_POR to readahead node blocks
> in restore_node_summary() instead of ra_sum_pages(), hence we can simplify the
> readahead code there, and also we can remove unused function ra_sum_pages().
>
> changes from v1:
>  o fix one bug when using truncate_inode_pages_range which is pointed out by
>    Jaegeuk Kim.
>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/node.c | 68 +++++++++++++---------------------------------------------
>  1 file changed, 15 insertions(+), 53 deletions(-)
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 5aa54a0..ab48b4c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1726,80 +1726,42 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>         return 0;
>  }
>
> -/*
> - * ra_sum_pages() merge contiguous pages into one bio and submit.
> - * these pre-read pages are allocated in bd_inode's mapping tree.
> - */
> -static int ra_sum_pages(struct f2fs_sb_info *sbi, struct page **pages,
> -                               int start, int nrpages)
> -{
> -       struct inode *inode = sbi->sb->s_bdev->bd_inode;
> -       struct address_space *mapping = inode->i_mapping;
> -       int i, page_idx = start;
> -       struct f2fs_io_info fio = {
> -               .type = META,
> -               .rw = READ_SYNC | REQ_META | REQ_PRIO
> -       };
> -
> -       for (i = 0; page_idx < start + nrpages; page_idx++, i++) {
> -               /* alloc page in bd_inode for reading node summary info */
> -               pages[i] = grab_cache_page(mapping, page_idx);
> -               if (!pages[i])
> -                       break;
> -               f2fs_submit_page_mbio(sbi, pages[i], page_idx, &fio);
> -       }
> -
> -       f2fs_submit_merged_bio(sbi, META, READ);
> -       return i;
> -}
> -
>  int restore_node_summary(struct f2fs_sb_info *sbi,
>                         unsigned int segno, struct f2fs_summary_block *sum)
>  {
>         struct f2fs_node *rn;
>         struct f2fs_summary *sum_entry;
> -       struct inode *inode = sbi->sb->s_bdev->bd_inode;
>         block_t addr;
>         int bio_blocks = MAX_BIO_BLOCKS(sbi);
> -       struct page *pages[bio_blocks];
> -       int i, idx, last_offset, nrpages, err = 0;
> +       int i, idx, last_offset, nrpages;
>
>         /* scan the node segment */
>         last_offset = sbi->blocks_per_seg;
>         addr = START_BLOCK(sbi, segno);
>         sum_entry = &sum->entries[0];
>
> -       for (i = 0; !err && i < last_offset; i += nrpages, addr += nrpages) {
> +       for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
>                 nrpages = min(last_offset - i, bio_blocks);
>
>                 /* readahead node pages */
> -               nrpages = ra_sum_pages(sbi, pages, addr, nrpages);
> -               if (!nrpages)
> -                       return -ENOMEM;
> +               ra_meta_pages(sbi, addr, nrpages, META_POR);
>
> -               for (idx = 0; idx < nrpages; idx++) {
> -                       if (err)
> -                               goto skip;
> +               for (idx = addr; idx < addr + nrpages; idx++) {
> +                       struct page *page = get_meta_page(sbi, idx);
>
> -                       lock_page(pages[idx]);
> -                       if (unlikely(!PageUptodate(pages[idx]))) {
> -                               err = -EIO;
> -                       } else {
> -                               rn = F2FS_NODE(pages[idx]);
> -                               sum_entry->nid = rn->footer.nid;
> -                               sum_entry->version = 0;
> -                               sum_entry->ofs_in_node = 0;
> -                               sum_entry++;
> -                       }
> -                       unlock_page(pages[idx]);
> -skip:
> -                       page_cache_release(pages[idx]);
> +                       rn = F2FS_NODE(page);
> +                       sum_entry->nid = rn->footer.nid;
> +                       sum_entry->version = 0;
> +                       sum_entry->ofs_in_node = 0;
> +                       sum_entry++;
> +                       f2fs_put_page(page, 1);
>                 }
>
> -               invalidate_mapping_pages(inode->i_mapping, addr,
> -                                                       addr + nrpages);
> +               truncate_inode_pages_range(META_MAPPING(sbi),
> +                               addr << PAGE_CACHE_SHIFT,
> +                               ((addr + nrpages) << PAGE_CACHE_SHIFT) - 1);
>         }
> -       return err;
> +       return 0;
>  }
>
>  static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> --
> 2.1.2
>
>
>
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
