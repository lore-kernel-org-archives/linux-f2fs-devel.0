From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 1/8] fsck.f2fs: do not set fix_on directly
Date: Tue, 31 Oct 2017 19:12:52 +0800
Message-ID: <962294c3-e179-39d8-d1f2-baf535196e9e@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <225753a9-68b7-3c98-ffac-55c6c79941eb@huawei.com>
 <b00a3c1e-2fa3-dc1c-a4c7-37707d52b478@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9UTv-0007hk-KG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 11:13:19 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e9UTt-0001f2-LL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 11:13:19 +0000
In-Reply-To: <b00a3c1e-2fa3-dc1c-a4c7-37707d52b478@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 17:34, Sheng Yong wrote:
> 
> 
> On 2017/10/31 15:06, Chao Yu wrote:
>> On 2017/10/31 9:38, Sheng Yong wrote:
>>> Do not set fix_on if it is allowed by user.
>>>
>>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>>> ---
>>>   fsck/main.c  | 2 +-
>>>   fsck/mount.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fsck/main.c b/fsck/main.c
>>> index c9411eb..93037e1 100644
>>> --- a/fsck/main.c
>>> +++ b/fsck/main.c
>>> @@ -429,7 +429,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
>>>   				c.fix_on = 1;
>>>   			break;
>>>   		}
>>> -	} else {
>>> +	} else if (c.preen_mode) {
>>
>> Needs to update below comments?
> I think the new condition hits comment 3 ("fsck -p 1 && error is detected, then
> bug_on is set fix_on = 1 here, so that fsck can fix errors automatically"). The
> condition was missing and the comment seems not that correct before ;)

OK, so please fix it in your patch. :)

Thanks,

> 
> thanks,
> Sheng
>>
>>>   		/*
>>>   		 * we can hit this in 3 situations:
>>>   		 *  1. fsck -f, fix_on has already been set to 1 when
>>> diff --git a/fsck/mount.c b/fsck/mount.c
>>> index 29af3b7..faa9bc8 100644
>>> --- a/fsck/mount.c
>>> +++ b/fsck/mount.c
>>> @@ -1879,6 +1879,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
>>>   
>>>   	memset(&nat_block->entries[entry_off], 0,
>>>   					sizeof(struct f2fs_nat_entry));
>>> +	FIX_MSG("Remove nid [0x%x] in NAT\n", nid);
>>
>> How about adding debug message in separated patch?
>>
>> Thanks,
>>
>>>   
>>>   	ret = dev_write_block(nat_block, block_addr);
>>>   	ASSERT(ret >= 0);
>>> @@ -2031,7 +2032,6 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
>>>   				 */
>>>   				ASSERT_MSG("Invalid nat entry[0]: "
>>>   					"blk_addr[0x%x]\n", ni.blk_addr);
>>> -				c.fix_on = 1;
>>>   				fsck->chk.valid_nat_entry_cnt--;
>>>   			}
>>>   
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
