From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [bug report] f2fs: use rb_*_cached friends
Date: Thu, 10 Jan 2019 14:51:21 -0800
Message-ID: <20190110225119.GE149637@gmail.com>
References: <20181011122342.GA23299@mwanda>
 <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1ghjAh-0008Kz-T1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jan 2019 22:51:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ghjAf-00AEB5-GS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jan 2019 22:51:31 +0000
Content-Disposition: inline
In-Reply-To: <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Fri, Oct 12, 2018 at 10:00:20PM +0800, Chao Yu wrote:
> Hi Dan,
> 
> Firstly, thanks for the report. :)
> 
> On 2018-10-11 20:23, Dan Carpenter wrote:
> > Hello Chao Yu,
> > 
> > The patch df634f444ee9: "f2fs: use rb_*_cached friends" from Oct 4,
> > 2018, leads to the following static checker warning:
> > 
> > 	fs/f2fs/extent_cache.c:606 f2fs_update_extent_tree_range()
> > 	error: uninitialized symbol 'leftmost'.
> > 
> > fs/f2fs/extent_cache.c
> >    497  static void f2fs_update_extent_tree_range(struct inode *inode,
> >    498                                  pgoff_t fofs, block_t blkaddr, unsigned int len)
> >    499  {
> >    500          struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >    501          struct extent_tree *et = F2FS_I(inode)->extent_tree;
> >    502          struct extent_node *en = NULL, *en1 = NULL;
> >    503          struct extent_node *prev_en = NULL, *next_en = NULL;
> >    504          struct extent_info ei, dei, prev;
> >    505          struct rb_node **insert_p = NULL, *insert_parent = NULL;
> >    506          unsigned int end = fofs + len;
> >    507          unsigned int pos = (unsigned int)fofs;
> >    508          bool updated = false;
> >    509          bool leftmost;
> >    510  
> >    511          if (!et)
> >    512                  return;
> >    513  
> >    514          trace_f2fs_update_extent_tree_range(inode, fofs, blkaddr, len);
> >    515  
> >    516          write_lock(&et->lock);
> >    517  
> >    518          if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
> >    519                  write_unlock(&et->lock);
> >    520                  return;
> >    521          }
> >    522  
> >    523          prev = et->largest;
> >    524          dei.len = 0;
> >    525  
> >    526          /*
> >    527           * drop largest extent before lookup, in case it's already
> >    528           * been shrunk from extent tree
> >    529           */
> >    530          __drop_largest_extent(et, fofs, len);
> >    531  
> >    532          /* 1. lookup first extent node in range [fofs, fofs + len - 1] */
> >    533          en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
> >    534                                          (struct rb_entry *)et->cached_en, fofs,
> >    535                                          (struct rb_entry **)&prev_en,
> >    536                                          (struct rb_entry **)&next_en,
> >    537                                          &insert_p, &insert_parent, false,
> >    538                                          &leftmost);
> >                                                  ^^^^^^^^
> > Not always initialized in there.
> 
> I think the behavior should be acting as designed.
> 
> f2fs_lookup_rb_tree_ret()
> {
> ...
> 	*insert_p = NULL;
> 	*insert_parent = NULL;
> 	*prev_entry = NULL;
> 	*next_entry = NULL;
> 
> 	if (RB_EMPTY_ROOT(&root->rb_root))
> 		return NULL;
> 
> 	if (re) {
> 		if (re->ofs <= ofs && re->ofs + re->len > ofs)
> 			goto lookup_neighbors;
> 	}
> 
> Until here, @leftmost has not been initialized, but both *insert_p and
> *insert_parent are NULL,
> 
> 	if (leftmost)
> 		*leftmost = true;
> ...
> }
> 
> Later in __insert_extent_tree()
> 
> we will not hit below condition because insert_p & insert_parent are not valid:
> 	if (insert_p && insert_parent) {
> 		parent = insert_parent;
> 		p = insert_p;
> 		goto do_insert;
> 	}
> 
> 	leftmost = true;
> 
> So finally, we will initialize leftmost's value here, anyway, I think there is
> such place we use an uninitialized variable.
> 
> BTW, do we have any chance to detect such case in smatch?
> 
> Thanks,
> 
> > 
> >    539          if (!en)
> >    540                  en = next_en;
> >    541  
> >    542          /* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
> >    543          while (en && en->ei.fofs < end) {
> >    544                  unsigned int org_end;
> >    545                  int parts = 0;  /* # of parts current extent split into */
> >    546  
> >    547                  next_en = en1 = NULL;
> >    548  
> >    549                  dei = en->ei;
> >    550                  org_end = dei.fofs + dei.len;
> >    551                  f2fs_bug_on(sbi, pos >= org_end);
> >    552  
> >    553                  if (pos > dei.fofs &&   pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
> >    554                          en->ei.len = pos - en->ei.fofs;
> >    555                          prev_en = en;
> >    556                          parts = 1;
> >    557                  }
> >    558  
> >    559                  if (end < org_end && org_end - end >= F2FS_MIN_EXTENT_LEN) {
> >    560                          if (parts) {
> >    561                                  set_extent_info(&ei, end,
> >    562                                                  end - dei.fofs + dei.blk,
> >    563                                                  org_end - end);
> >    564                                  en1 = __insert_extent_tree(sbi, et, &ei,
> >    565                                                          NULL, NULL, true);
> >    566                                  next_en = en1;
> >    567                          } else {
> >    568                                  en->ei.fofs = end;
> >    569                                  en->ei.blk += end - dei.fofs;
> >    570                                  en->ei.len -= end - dei.fofs;
> >    571                                  next_en = en;
> >    572                          }
> >    573                          parts++;
> >    574                  }
> >    575  
> >    576                  if (!next_en) {
> >    577                          struct rb_node *node = rb_next(&en->rb_node);
> >    578  
> >    579                          next_en = rb_entry_safe(node, struct extent_node,
> >    580                                                  rb_node);
> >    581                  }
> >    582  
> >    583                  if (parts)
> >    584                          __try_update_largest_extent(et, en);
> >    585                  else
> >    586                          __release_extent_node(sbi, et, en);
> >    587  
> >    588                  /*
> >    589                   * if original extent is split into zero or two parts, extent
> >    590                   * tree has been altered by deletion or insertion, therefore
> >    591                   * invalidate pointers regard to tree.
> >    592                   */
> >    593                  if (parts != 1) {
> >    594                          insert_p = NULL;
> >    595                          insert_parent = NULL;
> >    596                  }
> >    597                  en = next_en;
> >    598          }
> >    599  
> >    600          /* 3. update extent in extent cache */
> >    601          if (blkaddr) {
> >    602  
> >    603                  set_extent_info(&ei, fofs, blkaddr, len);
> >    604                  if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
> >    605                          __insert_extent_tree(sbi, et, &ei,
> >    606                                          insert_p, insert_parent, leftmost);
> >                                                                          ^^^^^^^^
> > Smatch complains, but I'm to stupid to know if it's valid.
> > 
> >    607  
> >    608                  /* give up extent_cache, if split and small updates happen */
> >    609                  if (dei.len >= 1 &&
> >    610                                  prev.len < F2FS_MIN_EXTENT_LEN &&
> >    611                                  et->largest.len < F2FS_MIN_EXTENT_LEN) {
> >    612                          et->largest.len = 0;
> >    613                          et->largest_updated = true;
> >    614                          set_inode_flag(inode, FI_NO_EXTENT);
> >    615                  }
> >    616          }
> > 
> > regards,
> > dan carpenter
> > 

I get an UBSAN warning on this same line, so this seems to be a real bug.
It goes away if I initialize 'leftmost'.

To reproduce, build a kernel with CONFIG_F2FS_FS=y CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_UBSAN=y CONFIG_KASAN=y and run 'kvm-xfstests -c f2fs generic/397'.
(There's probably a better reproducer, but that's how I saw it.)

This is on latest mainline.

================================================================================
UBSAN: Undefined behaviour in fs/f2fs/extent_cache.c:605:4
load of value 255 is not a valid value for type '_Bool'
CPU: 0 PID: 94 Comm: kworker/u4:2 Not tainted 5.0.0-rc1-00043-g1bdbe22749207 #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: writeback wb_workfn (flush-254:32)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x70/0xa5 lib/dump_stack.c:113
 ubsan_epilogue+0xd/0x40 lib/ubsan.c:159
 __ubsan_handle_load_invalid_value+0x8e/0xa0 lib/ubsan.c:457
 f2fs_update_extent_tree_range+0x6e9/0x760 fs/f2fs/extent_cache.c:605
 f2fs_update_extent_cache+0xce/0xf0 fs/f2fs/extent_cache.c:804
 f2fs_update_data_blkaddr+0x18/0x20 fs/f2fs/data.c:639
 f2fs_outplace_write_data+0x63/0x130 fs/f2fs/segment.c:3147
 f2fs_do_write_data_page+0x3ae/0x7e0 fs/f2fs/data.c:1892
 __write_data_page+0x734/0xd00 fs/f2fs/data.c:1993
 f2fs_write_cache_pages+0x1fb/0x610 fs/f2fs/data.c:2160
 __f2fs_write_data_pages fs/f2fs/data.c:2273 [inline]
 f2fs_write_data_pages+0x3dc/0x450 fs/f2fs/data.c:2300
 do_writepages+0x43/0xf0 mm/page-writeback.c:2335
 __writeback_single_inode+0x56/0x660 fs/fs-writeback.c:1316
 writeback_sb_inodes+0x20b/0x6b0 fs/fs-writeback.c:1580
 wb_writeback+0x10f/0x510 fs/fs-writeback.c:1756
 wb_do_writeback fs/fs-writeback.c:1901 [inline]
 wb_workfn+0xa7/0x670 fs/fs-writeback.c:1942
 process_one_work+0x25d/0x670 kernel/workqueue.c:2153
 worker_thread+0x3e/0x3d0 kernel/workqueue.c:2296
 kthread+0x124/0x140 kernel/kthread.c:246
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
================================================================================
