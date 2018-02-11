From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: set_code_data in move_data_block
Date: Sun, 11 Feb 2018 03:51:14 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F05654832EB19@DGGEMA503-MBX.china.huawei.com>
References: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
 <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ekift-0006tz-L5
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 03:51:33 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekifs-0003ua-EN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 03:51:33 +0000
In-Reply-To: <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Songyunlong (Euler)" <yunlong.song@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>, "yunlong.song@icloud.com" <yunlong.song@icloud.com>
Cc: "miaoxie (A)" <miaoxie@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>



>-----Original Message-----
>From: Songyunlong (Euler)
>Sent: Sunday, February 11, 2018 11:35 AM
>To: jaegeuk@kernel.org; chao@kernel.org; Yuchao (T); yunlong.song@icloud.com
>Cc: miaoxie (A); Wangbintian; shengyong (A); heyunlei; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] f2fs: set_code_data in move_data_block
>
>Ping...
>
>move_data_block misses set_cold_data, then the F2FS_WB_CP_DATA will
>lack these data pages in move_data_block, and write_checkpoint can
>not make sure this pages committed to the flash.
>

Here, we write encrypted_page back, which belong to meta mapping.

Thanks.


>On 2018/2/8 20:33, Yunlong Song wrote:
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index b9d93fd..2095630 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>   	fio.op = REQ_OP_WRITE;
>>   	fio.op_flags = REQ_SYNC;
>>   	fio.new_blkaddr = newaddr;
>> +	set_cold_data(fio.page);
>>   	err = f2fs_submit_page_write(&fio);
>>   	if (err) {
>>   		if (PageWriteback(fio.encrypted_page))
>>
>
>--
>Thanks,
>Yunlong Song

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
