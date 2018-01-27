From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck: fix missing endian conversion
Date: Sat, 27 Jan 2018 13:47:33 +0800
Message-ID: <dfd5bfa2-6ec5-750f-6bbd-91f661e1c61b@huawei.com>
References: <1516959075-9717-1-git-send-email-heyunlei@huawei.com>
 <50db9265-b9e0-4975-dd67-681b4cc8e0d1@huawei.com>
 <42B685BFA705F94C860C6DD0752F05654831990C@DGGEMA503-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efJLO-0004mr-GP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 05:48:02 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efJLM-0002pa-I3
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 05:48:02 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F05654831990C@DGGEMA503-MBX.china.huawei.com>
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
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>

On 2018/1/27 11:53, heyunlei wrote:
> 
> 
>> -----Original Message-----
>> From: Yuchao (T)
>> Sent: Saturday, January 27, 2018 11:30 AM
>> To: heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Cc: Wangbintian; Jianing (Euler)
>> Subject: Re: [f2fs-dev][PATCH] fsck: fix missing endian conversion
>>
>> On 2018/1/26 17:31, Yunlei He wrote:
>>> This patch fix missing endian conversion in function
>>> build_nat_area_bitmap
>>
>> I note that there are some missing cases for f2fs_nat_entry::blocik_addr,
>> how about fixing them in this patch too?
> 
> 2224                 /* Clear the original bit and count */
> 2225                 if (fsck->entries[nid].block_addr != 0x0) {
> 
> You mean here? I checked the whole function and found only here
> exist this problem. Because of comparing with zero, so I didn't change
> here in previous patch. 

Yes, how about just using if (f2fs_nat_entry::blocik_addr) in both
write_nat_bits and build_nat_area_bitmap.

Thanks,

> 
> Thanks.  
> 
> 2226                         fsck->chk.valid_nat_entry_cnt--;
> 2227                         f2fs_clear_bit(nid, fsck->nat_area_bitmap);
> 2228                         if (le32_to_cpu(fsck->entries[nid].ino) == nid)
> 2229                                 fsck->nat_valid_inode_cnt--;
> 2230                 }
> 
>>
>> Thanks,
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
