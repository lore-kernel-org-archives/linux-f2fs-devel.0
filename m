From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: fix wrong curseg check
Date: Tue, 5 Sep 2017 20:43:09 +0800
Message-ID: <74b7ae57-85f0-213a-7d35-27bfffe001c5@kernel.org>
References: <20170826001055.4478-1-jaegeuk@kernel.org>
 <34b9300b-47e9-3736-7429-1cfbbf864999@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dpDCR-0004eY-Rp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Sep 2017 12:43:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dpDCQ-0005Bm-U5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Sep 2017 12:43:27 +0000
In-Reply-To: <34b9300b-47e9-3736-7429-1cfbbf864999@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

I still can hit kernel panic with this patch, the reason is reorder of log header
during mkfs is not actually executed, it needs to change as below.

On 2017/8/28 17:47, Chao Yu wrote:
> On 2017/8/26 8:10, Jaegeuk Kim wrote:
>> We should avoid i==j, otherwise we always assign 0~5 segments.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
>> ---
>>  mkfs/f2fs_format.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index b379e80..219c2a7 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -123,7 +123,7 @@ static void verify_cur_segs(void)
>>  
>>  	for (i = 0; i < NR_CURSEG_TYPE; i++) {
>>  		for (j = 0; j < NR_CURSEG_TYPE; j++)
>> -			if (c.cur_seg[i] == c.cur_seg[j])
>> +			if (i != j && c.cur_seg[i] == c.cur_seg[j])
>>  				break;

	if (i != j && c.cur_seg[i] == c.cur_seg[j])
		goto reorder;
return;

reorder:
c.cur_seg[0] = 0;

Thanks,

>>  	}
>>  
>>
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
