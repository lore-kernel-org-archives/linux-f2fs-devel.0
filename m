From: Hou Pengyang <houpengyang@huawei.com>
Subject: Re: [PATCH 1/3] f2fs: fix a memleak issue
Date: Tue, 28 Feb 2017 10:06:31 +0800
Message-ID: <58B4DB27.2090709@huawei.com>
References: <20170227130259.19987-1-houpengyang@huawei.com>
	<072cd19e-773a-af22-01bd-84d219b670c3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ciXBl-0003of-Ej
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 02:06:53 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciXBk-0003So-3i
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 02:06:53 +0000
In-Reply-To: <072cd19e-773a-af22-01bd-84d219b670c3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/27 21:52, Kinglong Mee wrote:
> On 2/27/2017 21:02, Hou Pengyang wrote:
>> [fix: ae75f0ca76 f2fs: introduce free nid bitmap]
>> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
>> ---
>>   fs/f2fs/node.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 6d43095..353c01d 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -2650,8 +2650,11 @@ int init_free_nid_cache(struct f2fs_sb_info *sbi)
>>
>>   	nm_i->nat_block_bitmap = f2fs_kvzalloc(nm_i->nat_blocks / 8,
>>   								GFP_KERNEL);
>> -	if (!nm_i->nat_block_bitmap)
>> +	if (!nm_i->nat_block_bitmap) {
>> +		kvfree(nm_i->free_nid_bitmap);
>>   		return -ENOMEM;
>> +	}
>> +
>>   	return 0;
>>   }
>
> If building node manager fail, destroy_node_manager will be called,
> I think there isn't any memory leak exist, right?
>
>          err = build_node_manager(sbi);
>          if (err) {
>                  f2fs_msg(sb, KERN_ERR,
>                          "Failed to initialize F2FS node manager");
>                  goto free_nm;
>          }
>
>
Yup, I missed it :)
Thank you,

> thanks,
> Kinglong Mee
>
>



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
