From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: Change sysfs path look up logic
 for zoned block devices
Date: Fri, 19 Apr 2019 11:48:20 +0800
Message-ID: <072a5339-4dba-84f6-3d56-8b903fad3a0e@huawei.com>
References: <20190410085659.9005-1-shinichiro.kawasaki@wdc.com>
 <b28f3e2b-dd92-772a-d1f4-32c547cc41b3@huawei.com>
 <BN3PR04MB22578448AD68CBA1EAFC5F92ED270@BN3PR04MB2257.namprd04.prod.outlook.com>
 <a33c8263-94eb-9f5a-653b-e7cec4e7bc50@huawei.com>
 <BYAPR04MB5816A2729FA179EE7ABA4886E7270@BYAPR04MB5816.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHKVq-00055X-OA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 03:48:30 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHKVp-00FqVa-Fk
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 03:48:30 +0000
In-Reply-To: <BYAPR04MB5816A2729FA179EE7ABA4886E7270@BYAPR04MB5816.namprd04.prod.outlook.com>
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
To: Damien Le Moal <Damien.LeMoal@wdc.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2019/4/19 10:14, Damien Le Moal wrote:
> On 2019/04/19 11:05, Chao Yu wrote:
>> Hi Shinichiro,
>>
>> On 2019/4/19 9:18, Shinichiro Kawasaki wrote:
>>>
>>> I don't think so. The major scenario that read_file() returns NULL is fopen 
>>> fails to read /sys/dev/block/%s/partition. It indicates that the target device 
>>> is not a partition device. The sys_path and following code is still valid for 
>>> the non-partition device.
>>
>> I guess you mean the case that ../partition is not existed, right? so we should
>> check errno to confirm that?
>>
>>>
>>> The other minor read_file() NULL return scenario is strdup() failure because of 
>>> memory shortage. Do you think f2fs-tools need strdup() return value check? If 
>>> you suggest it, I will update the patch.
>>
>> Yes, I think we need to handle that as well.
> 
> Chao,

Hi Damien,

> 
> I talked with Shinichiro. The original code is in fact mostly OK, modulo a
> change to get the correct path to the "zoned" sysfs attribute file for partition
> block devices. There is also one thing missing in the original patch, namely a
> check for ENOENT error on fopen(). With these 2 changes, every error case will
> be correctly covered.
> 
> Shinichiro v2 patch will introduce these 2 fixes.

Thanks for your explanation, will check v2 later once it is sent out. :)

Thanks,

> 
> Best regards.
> 
