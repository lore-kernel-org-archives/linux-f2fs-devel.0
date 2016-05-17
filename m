From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [RFC] f2fs: fix a race condition between evict & gc
Date: Tue, 17 May 2016 11:00:53 +0800
Message-ID: <573A8965.9060900@huawei.com>
References: <1463395221-109622-1-git-send-email-houpengyang@huawei.com>
	<7ab55f84-5ad7-8986-12a3-0e9c8c96e54e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1b2VGD-0007Z7-GM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 May 2016 03:01:29 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b2VG6-0004K3-Fc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 May 2016 03:01:29 +0000
In-Reply-To: <7ab55f84-5ad7-8986-12a3-0e9c8c96e54e@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/5/16 23:10, Chao Yu wrote:
Hi chao,
> Hi Pengyang,
>
> On 2016/5/16 18:40, Hou Pengyang wrote:
>> When collecting data segment(gc_data_segment), there is a race condition
>> between evict and phases of gc:
>> 0) ra_node_page(dnode)
>> 1) ra_node_page(inode)
>> 		<--- evict the inode
>> 2) f2fs_iget get the inode and add it to gc_list
>> 3) move_data_page
>>
>> In step 2), f2fs_iget does NOT find the inode and allocs a new inode as result,
>
> If inode was unlinked and then be evicted, f2fs_iget should fail when reading
> inode's page as blkaddr of this node is null.
agree, after do_read_inode fail, the newly created inode would be
freed as a bad inode and f2fs_iget fails. But this may lead to create
file fail:
gc:iget_locked
        <---- touch/mkdir(reuse the evicted ino)
gc:free the bad inode

during the bad inode allocated and freed in gc, the inode is reserved
in the global inode_hash, while the ino is a free nid in free_nid tree.

touch/mkdir may reuse the ino, during the touch/mkdir path, the global
inode_hash would be checked if the ino file exists. Under this
scenario, because of the gc bad inode in inode_hash, touch/mkdir would
fail.

ilookup seems better, as no need to alloc and free a bad inode.

if ilookup fails, that exactly means inode has been evicted and no need
to gc;
if ilookup success, before phase 3, is_alive to deal with the ino reuse
scenario;

Do I miss anything else?
thanks
> If inode still have non-zero nlink value and then be evicted, we should allow gc
> thread to reference this inode for moving its data pages.
>
> Thanks,
>
>> which is not resonable.
>>
>> This patch changes f2fs_iget to ilookup. when no inode is found, no new inode is
>> created.
>>
>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>> ---
>>   fs/f2fs/gc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 38d56f6..6e73193 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -717,8 +717,8 @@ next_step:
>>   		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
>>
>>   		if (phase == 2) {
>> -			inode = f2fs_iget(sb, dni.ino);
>> -			if (IS_ERR(inode) || is_bad_inode(inode))
>> +			inode = ilookup(sb, dni.ino);
>> +			if (!inode || IS_ERR(inode) || is_bad_inode(inode))
>>   				continue;
>>
>>   			/* if encrypted inode, let's go phase 3 */
>>
>
> .
>



------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
