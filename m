From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] attr: adbjust acl_max of f2fs
Date: Wed, 3 May 2017 16:07:46 +0800
Message-ID: <c6f4fed6-7d9d-c64c-f65c-9f853e56044b@huawei.com>
References: <20170428131307.3384-1-chao@kernel.org>
	<20170503072943.GE7250@eguan.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d5pKx-0000BH-0D
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 08:08:39 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d5pKr-0001HJ-GM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 08:08:38 +0000
In-Reply-To: <20170503072943.GE7250@eguan.usersys.redhat.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eryu Guan <eguan@redhat.com>, jaegeuk@kernel.org
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/5/3 15:29, Eryu Guan wrote:
> On Fri, Apr 28, 2017 at 09:13:07PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> f2fs has set inline_xattr as a default option, and introduced a new option
>> named 'noinline_xattr' for disabling default inline_xattr option. So in
>> _acl_get_max we need to check 'noinline_xattr' string in fs option,
>> otherwise we may select the wrong max acl number since we always found
>> the string 'ininline_xattr' in fs option.
>>
>> Additionally, f2fs has changed disk layout of xattr block a bit, so will
>> contain one more entry in both inline and noinline xattr inode, this patch
>> will modify the max acl number to adjust it.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks for the patch! It looks fine to me from fstests POV, but need
> review from f2fs developers too.

Eryu, thanks for the review. ;)

To Jaegeuk, could you help to review this patch?

Thanks,

> 
> Thanks,
> Eryu
> 
>> ---
>>  common/attr | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index ac139e61..6d4f68ed 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -43,11 +43,11 @@ _acl_get_max()
>>  		echo 8191
>>  		;;
>>  	f2fs)
>> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>>  		if [ $? -eq 0 ]; then
>> -			echo 531
>> +			echo 507
>>  		else
>> -			echo 506
>> +			echo 532
>>  		fi
>>  		;;
>>  	*)
>> -- 
>> 2.12.2.575.gb14f27f
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
