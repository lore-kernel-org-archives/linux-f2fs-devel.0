From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] fsck.f2fs: check nid range before use to avoid
 segmentation fault
Date: Sat, 23 Dec 2017 11:35:50 +0800
Message-ID: <88632fa0-ec8d-ecf0-656f-c52fbfdc9be2@huawei.com>
References: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
 <1513598025-160615-1-git-send-email-yunlong.song@huawei.com>
 <e912dbdb-3614-cee0-c7f7-2b5f6344466f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e912dbdb-3614-cee0-c7f7-2b5f6344466f@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Both are OK, since nid < root_ino cannot trigger segmentation fault 
(nat_block->entries[nid%NAT_ENTRY_PER_BLOCK]).

On 2017/12/23 11:14, Chao Yu wrote:
> On 2017/12/18 19:53, Yunlong Song wrote:
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> How about introducing IS_AVAILABLE_NID as below, and use it instead?
>
> #define IS_AVAILABLE_NID(sbi, nid)	(IS_VALID_NID(sbi, nid) && (nid >= root_ino))
>
> Thanks,
>
>> ---
>>   fsck/fsck.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index 11b8b0b..faf0663 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -740,7 +740,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>>   	for (idx = 0; idx < 5; idx++) {
>>   		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
>>   
>> -		if (nid != 0) {
>> +		if (nid != 0 && IS_VALID_NID(sbi, nid)) {
>>   			struct node_info ni;
>>   
>>   			get_node_info(sbi, nid, &ni);
>>
>
> .
>

-- 
Thanks,
Yunlong Song
