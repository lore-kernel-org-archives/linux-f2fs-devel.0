From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: fix to skip repairing initialized
 i_gc_failures
Date: Tue, 27 Nov 2018 14:07:14 +0800
Message-ID: <6b1a063e-6409-8b0a-c871-48ec1fb9f0b1@huawei.com>
References: <20181126141914.8238-1-chao@kernel.org>
 <20181127000435.GE55960@jaegeuk-macbookpro.roam.corp.google.com>
 <edd664ef-aa51-3453-442f-87c3fdf5d7ed@huawei.com>
 <20181127035246.GA79141@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gRWWt-00074x-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 06:07:27 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRWWr-00GuPu-8t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 06:07:27 +0000
In-Reply-To: <20181127035246.GA79141@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/11/27 11:52, Jaegeuk Kim wrote:
> On 11/27, Chao Yu wrote:
>> On 2018/11/27 8:04, Jaegeuk Kim wrote:
>>> On 11/26, Chao Yu wrote:
>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> As Michael reported:
>>>>
>>>> after updating to f2fs-tools 1.12.0, a routine fsck of my file systems
>>>> took quite a while and output ten-thousands instances of the following
>>>> line:
>>>>
>>>>> [FIX] (fsck_chk_inode_blk: 954)  --> Regular: 0xXYZ reset i_gc_failur=
es from 0x1 to 0x00
>>>>
>>>> In old kernel, we initialized i_gc_failures as 0x01, let's skip
>>>> resetting such unchanged initialized value to avoid unnecessary
>>>> repairing.
>>>>
>>>> Reported-by: Michael La=DF <bevan@bi-co.net>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fsck/fsck.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>>>> index 970d150..db0e72f 100644
>>>> --- a/fsck/fsck.c
>>>> +++ b/fsck/fsck.c
>>>> @@ -941,7 +941,9 @@ skip_blkcnt_fix:
>>>>  	}
>>>>  =

>>>>  	i_gc_failures =3D le16_to_cpu(node_blk->i.i_gc_failures);
>>>> -	if (ftype =3D=3D F2FS_FT_REG_FILE && i_gc_failures) {
>>>> +
>>>> +	/* old kernel initialized i_gc_failures as 0x01, skip repairing */
>>>> +	if (ftype =3D=3D F2FS_FT_REG_FILE && i_gc_failures > 1) {
>>>
>>> This will break the current implementation.
>>
>> Yeah, but I doubt that after repairing i_gc_failures, old kernel can sti=
ll
>> continue creating inodes in where .i_gc_failures equals to 0x01, then fs=
ck
>> will report such info each time..., can we relief fsck in such condition?
> =

> How about adding another preen mode?
> =

> For example,
>   - 2: same as 0, but skip some checks for old kernel

Good idea, let me change to add this in v2. :)

Thanks,

> =

>>
>> Thanks,
>>
>>>
>>>>  =

>>>>  		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
>>>>  				le32_to_cpu(node_blk->footer.ino), en,
>>>> -- =

>>>> 2.18.0
>>>
>>> .
>>>
> =

> .
> =
