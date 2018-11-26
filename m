From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to update new block address
 correctly for OPU
Date: Mon, 26 Nov 2018 15:08:44 +0800
Message-ID: <949f3ac3-c4d0-9a9a-8602-160794922cab@huawei.com>
References: <20181124221742.135673-1-zhujia13@huawei.com>
 <9389306a-beb5-1db6-4eed-9a4bf46810c6@huawei.com>
 <83d1b94c-9eb3-19a7-8340-ba111128f7ae@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gRB1B-0008Ju-To
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 07:09:17 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRB0v-00FJGa-Iw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 07:09:17 +0000
In-Reply-To: <83d1b94c-9eb3-19a7-8340-ba111128f7ae@huawei.com>
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
To: "Zhujia (Euler)" <zhujia13@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: jaizhu.zj@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Hi Jia,

On 2018/11/26 11:48, Zhujia (Euler) wrote:
> Hi=A0 Chao,
> =

> On 2018/11/26 10:01, Chao Yu wrote:
>> On 2018/11/25 6:17, Jia Zhu wrote:
>>> Previously, we allocated a new block address for OPU mode in direct_IO.
>>>
>>> But the new address couldn't be assigned to @map->m_pblk correctly.
>>>
>>> This patch fix it.
>> Sorry to introduce this bug...
>>
>> It needs to Cc stable kernel mailing list and add 'Fixes' tag line.
> =

> I have checked the stable kernel branch and it hasn't merged the previous=
 patch yet.
> =

> Shall we still need to cc stable kernel mailing list and add 'Fixes' tag =
line?

Yes, please.

I think it will be useful to track important fixes to troubleshoot user
reported bug in mailing list or bugzilla, in addition, I think it can be
the hint for maintainers of other distribution of linux e.g. redhat, suse..
to backport fixes to their own version of kernel.

Thanks,

> =

> Thanks,
> =

> Jia Zhu
> =

>>> Signed-off-by: Jia Zhu <zhujia13@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>> ---
>>>  fs/f2fs/data.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7226300..a3a567a 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1110,8 +1110,10 @@ int f2fs_map_blocks(struct inode *inode, struct =
f2fs_map_blocks *map,
>>>  		if (test_opt(sbi, LFS) && flag =3D=3D F2FS_GET_BLOCK_DIO &&
>>>  							map->m_may_create) {
>>>  			err =3D __allocate_data_block(&dn, map->m_seg_type);
>>> -			if (!err)
>>> +			if (!err) {
>>> +				blkaddr =3D dn.data_blkaddr;
>>>  				set_inode_flag(inode, FI_APPEND_WRITE);
>>> +			}
>>>  		}
>>>  	} else {
>>>  		if (create) {
>>>
>>
>> .
>>
> =

> =

> .
> =
