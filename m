From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] check: recognize f2fs through parameter
Date: Sun, 7 Oct 2018 21:51:48 +0800
Message-ID: <05f43b5d-0e67-ba87-63dd-e45e8bd4c371@kernel.org>
References: <20180930092653.122684-1-yuchao0@huawei.com>
 <20181006093207.GI17817@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1g99TT-00078V-Pk
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:51:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g99TS-00Dsz5-7g
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Oct 2018 13:51:59 +0000
In-Reply-To: <20181006093207.GI17817@desktop>
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
To: Eryu Guan <guaneryu@gmail.com>, Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018-10-6 17:32, Eryu Guan wrote:
> On Sun, Sep 30, 2018 at 05:26:52PM +0800, Chao Yu wrote:
>> Add a paramenter in check to configure $FSTYP for f2fs.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  check | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/check b/check
>> index f3c8021d94b9..a9024094721a 100755
>> --- a/check
>> +++ b/check
>> @@ -59,6 +59,7 @@ check options
>>      -pvfs2          test PVFS2
>>      -tmpfs              test TMPFS
>>      -ubifs              test ubifs
>> +    -f2fs		test f2fs
>>      -l			line mode diff
>>      -udiff		show unified diff (default)
>>      -n			show me, do not run tests
>> @@ -263,6 +264,7 @@ while [ $# -gt 0 ]; do
>>  	-pvfs2)		FSTYP=pvfs2 ;;
>>  	-tmpfs)		FSTYP=tmpfs ;;
>>  	-ubifs)		FSTYP=ubifs ;;
>> +	-f2fs)		FSTYP=f2fs ;;
> 
> The test harness should be able to detect the f2fs type from $TEST_DEV.
> We add param to set FSTYP only when there's no way to tell the
> filesystem type from the device.

Hi Eryu,

Okay, thanks for the explanation, let's just ignore this patch.

Thanks,

> 
> Thanks,
> Eryu
> 
>>  
>>  	-g)	group=$2 ; shift ;
>>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
>> -- 
>> 2.18.0.rc1
>>
