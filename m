From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH v4] f2fs: support in-memory inode checksum
 when checking consistency
Date: Thu, 8 Mar 2018 21:22:07 +0800
Message-ID: <ad03da98-ea37-7b94-2b36-18eea6f67917@huawei.com>
References: <20180307211040.219117-1-guoweichao@huawei.com>
 <472de3e0-b4e9-d2e3-67d2-a0f060f5f06e@huawei.com>
 <3553bd60-494f-92a0-7368-aacd6bfd3f99@huawei.com>
 <c04d8c15-dbeb-ccf5-eb5c-0be4a976e3ef@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoweichao@huawei.com>) id 1etvVG-0002br-MI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 13:22:38 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etvVE-004NdB-9N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 13:22:38 +0000
In-Reply-To: <c04d8c15-dbeb-ccf5-eb5c-0be4a976e3ef@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On 2018/3/8 17:11, Chao Yu wrote:
> Hi Weichao,
> 
> On 2018/3/8 15:56, guoweichao wrote:
>> Hi Chao,
>>
>> On 2018/3/8 14:15, Chao Yu wrote:
>>> On 2018/3/8 5:10, Weichao Guo wrote:
>>>> Only enable in-memory inode checksum to protect metadata blocks
>>>> from in-memory scribbles when checking consistency, which has no
>>>> performance requirements.
>>>
>>> Once we modify the node page of inode, we will call set_page_dirty, not sure,
>>> can you check that we can just call f2fs_inode_chksum_set in set_page_dirty?
>>>
>> In most cases, we call set_page_dirty after modifying the node page of inode.
>> But in the case of update_inode, set_page_dirty is called before modifying the node page.
> 
> IIRC, we can not change that order, but we can add addition
> f2fs_inode_chksum_set in the end of update_inode.
> 
>> And in fsync_node_pages, if the node page of inode is already dirtied, set_page_dirty will
>> be skipped.
I reviewed this case: we call __write_node_page after set dentry/fsync flag in node footer of
the inode page, and no need to update inode checksum here. It's safe.

Another case is f2fs_do_tmpfile, when init_inode_metadata, if inode is not in FI_NEW_INODE state,
cold bit in the node footer is set and there is no set_page_dirty followed.
IMO, the inode should be FI_NEW_INODE in init_inode_metada when creating temp file.
So we don't have to worry about it.

Thanks,
> 
> We can handle that exception by adding f2fs_inode_chksum_set there too.
> 
> Thanks,
> 
>>
>> IMO, calling f2fs_inode_chksum_set in set_page_dirty is more clear and reasonable.
>> Can we add or move set_page_dirty in the exceptional cases?
>>
>> Thank,
>>
>>> Thanks,
>>>
>>>
>>> .
>>>
>>
>>
>> .
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
