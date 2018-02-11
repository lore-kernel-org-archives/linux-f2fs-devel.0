From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: set_code_data in move_data_block
Date: Sun, 11 Feb 2018 14:15:45 +0800
Message-ID: <8856fc96-03a8-b2d8-8639-512ba2ecb893@huawei.com>
References: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
 <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
 <520ce370-daa0-0654-3992-be01e8d82607@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <520ce370-daa0-0654-3992-be01e8d82607@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

OK, Got it.

On 2018/2/11 11:50, Chao Yu wrote:
> On 2018/2/11 11:34, Yunlong Song wrote:
>> Ping...
>>
>> move_data_block misses set_cold_data, then the F2FS_WB_CP_DATA will
>> lack these data pages in move_data_block, and write_checkpoint can
>> not make sure this pages committed to the flash.
> 
> Hmm.. data block migration is running based on meta inode, so it will
> be safe since checkpoint will flush all meta pages including encrypted
> pages cached in meta inode?
> 
> Thanks,
> 
>>
>> On 2018/2/8 20:33, Yunlong Song wrote:
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>    fs/f2fs/gc.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index b9d93fd..2095630 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>    	fio.op = REQ_OP_WRITE;
>>>    	fio.op_flags = REQ_SYNC;
>>>    	fio.new_blkaddr = newaddr;
>>> +	set_cold_data(fio.page);
>>>    	err = f2fs_submit_page_write(&fio);
>>>    	if (err) {
>>>    		if (PageWriteback(fio.encrypted_page))
>>>
>>
> 
> 
> .
> 

-- 
Thanks,
Yunlong Song
