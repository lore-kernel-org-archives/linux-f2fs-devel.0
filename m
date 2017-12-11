From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH RFC] f2fs: fix an error case of missing
 update inode page
Date: Mon, 11 Dec 2017 21:31:06 +0800
Message-ID: <5746805f-6679-d278-0ea5-848f7a07f4af@kernel.org>
References: <1512446867-29122-1-git-send-email-heyunlei@huawei.com>
 <20171208052650.GB77074@jaegeuk-macbookpro.roam.corp.google.com>
 <42B685BFA705F94C860C6DD0752F0565482E9B01@DGGEMA503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eOOB1-0000cq-MI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 13:31:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eOOB0-0002PV-RT
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 13:31:23 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F0565482E9B01@DGGEMA503-MBS.china.huawei.com>
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
To: heyunlei <heyunlei@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2017/12/8 13:44, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>> Sent: Friday, December 08, 2017 1:27 PM
>> To: heyunlei
>> Cc: Yuchao (T); linux-f2fs-devel@lists.sourceforge.net; Wangbintian; Jianing (Euler)
>> Subject: Re: [f2fs-dev][PATCH RFC] f2fs: fix an error case of missing update inode page
>>
>> On 12/05, Yunlei He wrote:
>>> -Thread A					Thread B
>>>
>>> -write_checkpoint
>>> 	-block_operations
>>> 		-f2fs_unlock_all		-f2fs_sync_file
>>> 							-f2fs_write_inode
>>> 								-f2fs_inode_synced
>>>
>>> 			-f2fs_sync_inode_meta
>>> 				-sync_node_pages
>>> 									-set_page_drity
>>>
>>> In this case, if sudden power off without next new checkpoint,
>>> the last inode page update will lost. wb_writeback is same with
>>> fsync.
>>
>> BTW, what do you mean wb_writeback is same with fsync?
> 
> Background write back will call f2fs_write_inode, which is same with f2fs_sync_file.

Can you add related call stack in commit log? Other part looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
