From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v5] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Thu, 4 Jan 2018 11:07:44 +0800
Message-ID: <1da289c3-dedc-1391-4ee9-af66a8fc6f6b@huawei.com>
References: <1513746212-19454-1-git-send-email-heyunlei@huawei.com>
 <b74925d3-4a2f-f363-497f-00e754891fb0@huawei.com>
 <20171228023731.GC13490@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eWvt7-0006u6-SE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 03:08:13 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWvt5-0001Rz-L3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 03:08:13 +0000
In-Reply-To: <20171228023731.GC13490@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Yunlei He <heyunlei@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, ning.jia@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Yunlei,

Could you rework this patch as we discussed?

Thanks,

On 2017/12/28 10:37, Jaegeuk Kim wrote:
> On 12/25, Chao Yu wrote:
>> On 2017/12/20 13:03, Yunlei He wrote:
>>> v4 -> v5 return err instead destory inode list for two reasons:
>>> i.  avoid duplicated destroy inode list in function recover_fsync_data.
>>> ii. report an error for recovery, and set need_fsck flag
>>
>> fsck can't fix this issue so far, it doesn't work even we set need_fsck flag,
>> would it be better to just drop last dnode with corrupted next_blkaddr and try
>> our best to recover fsynced data?
> 
> Yup, agreed to this. There's no way to recover this, if we just return an error.
> 
>>
>> Thanks,
>>
>>>         
>>> Came across a dead loop in recovery like this:
>>>
>>> ......
>>> [   24.680480s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597696
>>> [   24.698394s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597697
>>> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> [   24.724426s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
>>> ......
>>>
>>> Mount process will block in dead loop and fsck can do nothing with this
>>> error, This patch abandon recovery if node chain is cyclical.
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> ---
>>>  fs/f2fs/recovery.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index d025aa8..a535ec2 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -216,6 +216,17 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
>>>  			return 0;
>>>  
>>>  		page = get_tmp_page(sbi, blkaddr);
>>> +		if (PageChecked(page)) {
>>> +			f2fs_msg(sbi->sb, KERN_ERR, "Abandon looped node block list");
>>> +			err = -EINVAL;
>>> +			break;
>>> +		}
>>> +
>>> +		/*
>>> +		 * it's not needed to clear PG_checked flag in temp page since we
>>> +		 * will truncate all those pages in the end of recovery.
>>> +		 */
>>> +		SetPageChecked(page);
>>>  
>>>  		if (!is_recoverable_dnode(page))
>>>  			break;
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
