From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [RFC] f2fs: fix a race condition between evict & gc
Date: Tue, 17 May 2016 10:23:20 -0700
Message-ID: <20160517172320.GA45096@jaegeuk.gateway>
References: <1463395221-109622-1-git-send-email-houpengyang@huawei.com>
 <7ab55f84-5ad7-8986-12a3-0e9c8c96e54e@kernel.org>
 <573A8965.9060900@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <573A8965.9060900@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hou Pengyang <houpengyang@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 17, 2016 at 11:00:53AM +0800, Hou Pengyang wrote:
> On 2016/5/16 23:10, Chao Yu wrote:
> Hi chao,
> > Hi Pengyang,
> >
> > On 2016/5/16 18:40, Hou Pengyang wrote:
> >> When collecting data segment(gc_data_segment), there is a race condition
> >> between evict and phases of gc:
> >> 0) ra_node_page(dnode)
> >> 1) ra_node_page(inode)
> >> 		<--- evict the inode
> >> 2) f2fs_iget get the inode and add it to gc_list
> >> 3) move_data_page
> >>
> >> In step 2), f2fs_iget does NOT find the inode and allocs a new inode as result,
> >
> > If inode was unlinked and then be evicted, f2fs_iget should fail when reading
> > inode's page as blkaddr of this node is null.
> agree, after do_read_inode fail, the newly created inode would be
> freed as a bad inode and f2fs_iget fails. But this may lead to create
> file fail:
> gc:iget_locked
>         <---- touch/mkdir(reuse the evicted ino)
> gc:free the bad inode

Seems there is no problem.

After f2fs_evict_inode(ino),

f2fs_iget(ino)
 - iget_failed()                          f2fs_create()
                                           - f2fs_new_inode()
                                           - ino = alloc_nid()
                                           - insert_inode_locked()
                                            *** spin_lock(&inode_hash_lock)
                                            - spin_lock(&old->i_lock)
                                            - __iget(old)
  - make_bad_inode()                        - spin_unlock(&old->i_lock)
   - remove_inode_hash()                    - spin_unlock(&inode_hash_lock)
    - spin_lock(&inode_hash_lock)           - wait_on_inode(old)
    - spin_lock(&inode->i_lock)
    - list_del
    - spin_unlock(&inode->i_lock)
    - spin_unlock(&inode_hash_lock)
   - unlock_new_inode()
    - wake_up_bit(&inode->i_state, __I_NEW) --> wake up!
                                            - iput(old) whish was unhashed.
                                            - goto to ***
   - iput()

> during the bad inode allocated and freed in gc, the inode is reserved
> in the global inode_hash, while the ino is a free nid in free_nid tree.
> 
> touch/mkdir may reuse the ino, during the touch/mkdir path, the global
> inode_hash would be checked if the ino file exists. Under this
> scenario, because of the gc bad inode in inode_hash, touch/mkdir would
> fail.
> 
> ilookup seems better, as no need to alloc and free a bad inode.
> 
> if ilookup fails, that exactly means inode has been evicted and no need
> to gc;

No, we should do gc for data blocks owned by *evicted* inodes as well.

Thanks,

> if ilookup success, before phase 3, is_alive to deal with the ino reuse
> scenario;
> 
> Do I miss anything else?
> thanks
> > If inode still have non-zero nlink value and then be evicted, we should allow gc
> > thread to reference this inode for moving its data pages.
> >
> > Thanks,
> >
> >> which is not resonable.
> >>
> >> This patch changes f2fs_iget to ilookup. when no inode is found, no new inode is
> >> created.
> >>
> >> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> >> ---
> >>   fs/f2fs/gc.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 38d56f6..6e73193 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -717,8 +717,8 @@ next_step:
> >>   		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
> >>
> >>   		if (phase == 2) {
> >> -			inode = f2fs_iget(sb, dni.ino);
> >> -			if (IS_ERR(inode) || is_bad_inode(inode))
> >> +			inode = ilookup(sb, dni.ino);
> >> +			if (!inode || IS_ERR(inode) || is_bad_inode(inode))
> >>   				continue;
> >>
> >>   			/* if encrypted inode, let's go phase 3 */
> >>
> >
> > .
> >
> 
> 
> 
> ------------------------------------------------------------------------------
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data untouched!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
