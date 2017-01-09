From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/5] f2fs: check in-memory block bitmap
Date: Mon, 9 Jan 2017 16:42:28 +0800
Message-ID: <19468696-d107-77b6-c8f6-734ae8292675@huawei.com>
References: <83098918-d882-8743-51bc-1e96038d6ad2@huawei.com>
	<20170108050208.GA16864@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cQVXy-0004e2-P5
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Jan 2017 08:43:18 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cQVXr-0001UP-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Jan 2017 08:43:18 +0000
In-Reply-To: <20170108050208.GA16864@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/1/8 13:02, Jaegeuk Kim wrote:
>> @@ -2786,6 +2811,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
>>  	if (sit_i->sentries) {
>>  		for (start = 0; start < MAIN_SEGS(sbi); start++) {
>>  			kfree(sit_i->sentries[start].cur_valid_map);
> 
> I added:
> 
> #ifdef CONFIG_F2FS_CHECK_FS

Oops, thanks for fixing it. :)

Thanks,

> 
>> +			kfree(sit_i->sentries[start].cur_valid_map_mir);
> 
> #endif
> 
> Thanks,
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
