From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid to use a NULL point in destroy_segment_manager
Date: Wed, 06 Nov 2013 13:15:36 +0800
Message-ID: <5279D078.8080803@cn.fujitsu.com>
References: <000001ceda8d$5b185bd0$11491370$@samsung.com> <5279BA67.4040906@cn.fujitsu.com> <000101cedaae$bb7ed820$327c8860$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000101cedaae$bb7ed820$327c8860$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: '???' <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?GB2312?B?J8y35q0n?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/06/2013 01:10 PM, Chao Yu wrote:

> Hi Gu,
>=20
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Wednesday, November 06, 2013 11:41 AM
>> To: Chao Yu
>> Cc: ???; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org=
; linux-f2fs-devel@lists.sourceforge.net; =CC=B7=E6=AD
>> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid to use a NULL point in d=
estroy_segment_manager
>>
>> On 11/06/2013 09:12 AM, Chao Yu wrote:
>>
>>> A NULL point should avoid to be used in destroy_segment_manager aft=
er allocating memory fail for f2fs_sm_info.
>>
>> Though without this patch it still can work well, because if it fail=
ed
>> to allocate f2fs_sm_info, the sit_info, free_info... all were NULL, =
and
>> the destory path(e.g. destroy_dirty_segmap) can deal with them well.
>=20
> I think it could not work well. Without this patch we may got a segme=
nt=20
> fault in DIRTY_I(sbi) at the following code if it failed to allocate=20
> f2fs_sm_info memory(sbi->sm_info). Right?

Yes, you're right. SIT_I generates sit_info from f2fs_sm_info.
Sorry for my mistake.:(

Regards,
Gu

>=20
> static void destroy_dirty_segmap(struct f2fs_sb_info *sbi)
> {
> 	struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
>=20
>> IMO, this patch is still a good catch.
>>
>> Regards,
>> Gu
>>
>>>
>>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>>> ---
>>>  fs/f2fs/segment.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 3d4d5fc..ff363e6
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1744,6 +1744,8 @@ static void destroy_sit_info(struct f2fs_sb_i=
nfo *sbi)
>>>  void destroy_segment_manager(struct f2fs_sb_info *sbi)
>>>  {
>>>  	struct f2fs_sm_info *sm_info =3D SM_I(sbi);
>>> +	if (!sm_info)
>>> +		return;
>>>  	destroy_dirty_segmap(sbi);
>>>  	destroy_curseg(sbi);
>>>  	destroy_free_segmap(sbi);
>=20
>=20
>=20
