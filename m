From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH 2/2] fsck.f2fs: check extra_attr feature
Date: Mon, 9 Jul 2018 11:01:12 +0800
Message-ID: <3cc8f064-81cc-5cfc-7496-0b39393b1ab3@huawei.com>
References: <20180703101005.200396-1-shengyong1@huawei.com>
 <20180703101005.200396-2-shengyong1@huawei.com>
 <8ef97448-5583-3914-015b-88fed0169b26@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fcMQo-0005fF-DQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 03:01:42 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcMQm-003rAB-9T
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Jul 2018 03:01:42 +0000
In-Reply-To: <8ef97448-5583-3914-015b-88fed0169b26@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, wen.xu@gatech.edu
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2018/7/9 10:15, Chao Yu wrote:
> Hi Sheng,
> 
> On 2018/7/3 18:10, Sheng Yong wrote:
>> Check extra_attr feature for inode. If it is corrupted, remove the
>> inode.
> 
> Could you check the patch:
> 
> [PATCH] fsck.f2fs: fix to do sanity check with extra_attr feature
> 
> Would it better to do sanity check with it in fsck_chk_inode_blk? since it is
> about consistence of inode instead of nid.
> 

Agree. And the patch has already checked the value of i_extra_isize, so this one
can be dropped :-)

Thanks

> Thanks,
> 
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200219
>> Reported-by: Wen Xu <wen.xu@gatech.edu>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>   fsck/fsck.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index 15264b2..acbe25d 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -460,6 +460,12 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>>   		__check_inode_mode(nid, ftype, le32_to_cpu(node_blk->i.i_mode)))
>>   		return -EINVAL;
>>   
>> +	if (ntype == TYPE_INODE &&
>> +			((f2fs_has_extra_isize(&node_blk->i) &&
>> +			  !(c.feature & F2FS_FEATURE_EXTRA_ATTR)) ||
>> +			 get_extra_isize(node_blk) >= DEF_ADDRS_PER_INODE))
>> +		return -EINVAL;
>> +
>>   	/* workaround to fix later */
>>   	if (ftype != F2FS_FT_ORPHAN ||
>>   			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0) {
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
