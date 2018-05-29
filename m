From: Chao Yu <chao@kernel.org>
Subject: Re: Cleaning up f2fs's use of the symbol namespace
Date: Wed, 30 May 2018 00:30:45 +0800
Message-ID: <ba47860b-2861-4ca4-47c1-320ed25a11fd@kernel.org>
References: <20180528200520.GA12213@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fNhWv-0006XW-3e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 16:31:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fNhWt-006xSN-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 16:31:25 +0000
In-Reply-To: <20180528200520.GA12213@thunk.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Hi Ted,

On 2018/5/29 4:05, Theodore Y. Ts'o wrote:
> Hi, I was looking at f2fs's sources recently, and I noticed that there
> is a very large number of non-static symbols which don't have a f2fs
> prefix.  There's well over a hundred (see attached below).
> 
> As one example, in fs/f2fs/dir.c there is:
> 
> unsigned char get_de_type(struct f2fs_dir_entry *de)
> 
> This function is clearly only useful for f2fs, but it has a generic
> name.  This means that if any other file system tries to have the same
> symbol name, there will be a symbol conflict and the kernel would not
> successfully build.  It also means that when someone is looking f2fs
> sources, it's not at all obvious whether a function such as
> read_data_page(), invalidate_blocks(), is a generic kernel function
> found in the fs, mm, or block layers, or a f2fs specific function.
> 
> You might want to fix this at some point.  Hopefully Kent's bcachefs
> isn't similarly using genericly named functions, since that might
> cause conflicts with f2fs's functions --- but just as this would be a
> problem that we would rightly insist that Kent fix, this is something
> that we should have rightly insisted that f2fs should have fixed
> before it was integrated into the mainline kernel.

Thanks for the report and suggestion, I think that makes sense to me. :)

To Jaegeuk, I wrote a patch for cleaning up exported symbols which have no
'f2fs_' prefix, could you please check it?

Thanks,

> 
> Cheers,
> 
> 						- Ted
> 
> 
> acquire_orphan_inode
> add_ino_entry
> add_orphan_inode
> allocate_data_block
> allocate_new_segments
> alloc_nid
> alloc_nid_done
> alloc_nid_failed
> available_free_memory
> build_free_nids
> build_gc_manager
> build_node_manager
> build_segment_manager
> __check_rb_tree_consistence
> clear_prefree_segments
> commit_inmem_pages
> create_checkpoint_caches
> create_extent_cache
> create_flush_cmd_control
> create_node_manager_caches
> create_segment_manager_caches
> destroy_checkpoint_caches
> destroy_extent_cache
> destroy_flush_cmd_control
> destroy_node_manager
> destroy_node_manager_caches
> destroy_segment_manager
> destroy_segment_manager_caches
> do_make_empty_dir
> do_write_data_page
> drop_discard_cmd
> drop_inmem_page
> drop_inmem_pages
> drop_inmem_pages_all
> exist_trim_candidates
> exist_written_data
> find_data_page
> find_in_inline_dir
> find_target_dentry
> flush_nat_entries
> flush_sit_entries
> fsync_node_pages
> get_de_type
> get_dnode_of_data
> get_lock_data_page
> get_meta_page
> get_new_data_page
> get_next_page_offset
> get_node_info
> get_node_page
> get_node_page_ra
> get_read_data_page
> get_sum_page
> get_tmp_page
> get_valid_checkpoint
> grab_meta_page
> handle_failed_inode
> init_discard_policy
> init_extent_cache_info
> init_inode_metadata
> init_ino_entry_info
> invalidate_blocks
> io_type_to_rw_hint
> is_checkpointed_data
> is_checkpointed_node
> is_dirty_device
> is_valid_blkaddr
> lookup_journal_in_cursum
> __lookup_rb_tree
> __lookup_rb_tree_for_insert
> __lookup_rb_tree_ret
> make_empty_inline_dir
> move_node_page
> need_dentry_mark
> need_inode_block_update
> need_SSR
> new_inode_page
> new_node_page
> npages_for_summary_flush
> ra_meta_pages
> ra_meta_pages_cond
> ra_node_page
> read_inline_data
> recover_fsync_data
> recover_inline_data
> recover_inline_xattr
> recover_inode_page
> recover_orphan_inodes
> recover_xattr_data
> register_inmem_page
> release_discard_addrs
> release_ino_entry
> release_orphan_inode
> remove_dirty_inode
> remove_inode_page
> remove_ino_entry
> remove_orphan_inode
> reserve_new_block
> reserve_new_blocks
> restore_node_summary
> rewrite_data_page
> room_for_filename
> rw_hint_to_seg_type
> sanity_check_ckpt
> set_data_blkaddr
> set_de_type
> set_dirty_device
> should_update_inplace
> should_update_outplace
> space_for_roll_forward
> start_bidx_of_node
> start_gc_thread
> stop_discard_thread
> stop_gc_thread
> sync_dirty_inodes
> sync_meta_pages
> sync_node_pages
> truncate_blocks
> truncate_data_blocks
> truncate_data_blocks_range
> truncate_hole
> truncate_inline_inode
> truncate_inode_blocks
> truncate_xattr_node
> try_to_free_nats
> try_to_free_nids
> update_dirty_page
> update_extension_list
> update_inode
> update_inode_page
> update_meta_page
> update_parent_metadata
> wait_on_node_pages_writeback
> write_checkpoint
> write_data_page
> write_data_summaries
> write_meta_page
> write_node_page
> write_node_summaries
> 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
