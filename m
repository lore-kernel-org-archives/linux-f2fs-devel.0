From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: fix wrong curseg check
Date: Wed, 6 Sep 2017 11:41:46 +0800
Message-ID: <b1846ac3-74f7-07b8-f46b-908b33be89dc@huawei.com>
References: <20170826001055.4478-1-jaegeuk@kernel.org>
 <34b9300b-47e9-3736-7429-1cfbbf864999@huawei.com>
 <74b7ae57-85f0-213a-7d35-27bfffe001c5@kernel.org>
 <20170905174704.GA36912@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dpRE0-0001Vr-82
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 03:42:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dpRDy-0003t8-AJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 03:42:00 +0000
In-Reply-To: <20170905174704.GA36912@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/9/6 1:47, Jaegeuk Kim wrote:
> On 09/05, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> I still can hit kernel panic with this patch, the reason is reorder of log header
>> during mkfs is not actually executed, it needs to change as below.
>>
>> On 2017/8/28 17:47, Chao Yu wrote:
>>> On 2017/8/26 8:10, Jaegeuk Kim wrote:
>>>> We should avoid i==j, otherwise we always assign 0~5 segments.
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>
>>>> ---
>>>>  mkfs/f2fs_format.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>> index b379e80..219c2a7 100644
>>>> --- a/mkfs/f2fs_format.c
>>>> +++ b/mkfs/f2fs_format.c
>>>> @@ -123,7 +123,7 @@ static void verify_cur_segs(void)
>>>>  
>>>>  	for (i = 0; i < NR_CURSEG_TYPE; i++) {
>>>>  		for (j = 0; j < NR_CURSEG_TYPE; j++)
>>>> -			if (c.cur_seg[i] == c.cur_seg[j])
>>>> +			if (i != j && c.cur_seg[i] == c.cur_seg[j])
>>>>  				break;
>>
>> 	if (i != j && c.cur_seg[i] == c.cur_seg[j])
> 
> Can be overflowed?
> 
> How about this?

It's OK to me. :)

Thanks,

> 
>>From 53923f74b188028c4f5a8b64b330f0d7b12adf24 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 24 Aug 2017 19:33:10 -0700
> Subject: [PATCH] mkfs.f2fs: fix wrong curseg check
> 
> We should avoid i==j, otherwise we always assign 0~5 segments.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  mkfs/f2fs_format.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index b379e80..8319f24 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -120,14 +120,18 @@ next:
>  static void verify_cur_segs(void)
>  {
>  	int i, j;
> +	bool reorder = false;
>  
>  	for (i = 0; i < NR_CURSEG_TYPE; i++) {
> -		for (j = 0; j < NR_CURSEG_TYPE; j++)
> -			if (c.cur_seg[i] == c.cur_seg[j])
> +		for (j = i + 1; j < NR_CURSEG_TYPE; j++) {
> +			if (c.cur_seg[i] == c.cur_seg[j]) {
> +				reorder = true;
>  				break;
> +			}
> +		}
>  	}
>  
> -	if (i == NR_CURSEG_TYPE && j == NR_CURSEG_TYPE)
> +	if (!reorder)
>  		return;
>  
>  	c.cur_seg[0] = 0;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
