From: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [RESEND PATCH] f2fs: no need to take the address of
 the array of sb->s_uuid
Date: Sun, 8 Apr 2018 21:47:05 +0800
Message-ID: <60c652f9-b1ea-063c-7e5f-9fdb04fd585e@huawei.com>
References: <94ebbd85-1b8d-927a-ae94-93aa6ded4e23@huawei.com>
 <26ef0398-7163-cc32-c995-97ddf58a07b1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoxiang25@huawei.com>) id 1f5AfM-0008Mk-1F
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 13:47:32 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5AfH-003Gdu-Ui
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 13:47:31 +0000
In-Reply-To: <26ef0398-7163-cc32-c995-97ddf58a07b1@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Gao Xiang <hsiangkao@aol.com>, hutj <hutj@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao and Jaegeuk,

On 2018/4/8 20:16, Chao Yu wrote:
> On 2018/4/5 11:58, Gao Xiang wrote:
>> Keep in line with the common case since it is some weird
>> to take the address of an array again.
> =

> I encounter compile error after applying this patch:
> =

> super.c: In function =91f2fs_fill_super=92:
> super.c:2711:2: error: incompatible type for argument 1 of =91__builtin_m=
emcpy=92
>   memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>   ^
> super.c:2711:2: note: expected =91void *=92 but argument is of type =91uu=
id_t=92
> =

> Anyway, we need '&' due to sb::s_uuid is a structure object instead of an=
 array.
> =

> Thanks,
> =

Sorry, I'm developing another feature related to it.
But I checked the source code about sb->uuid from 3.x to 4.9.
https://elixir.bootlin.com/linux/v4.9.93/source/include/linux/fs.h#L1382

It seems that the latest kernel changed from u8 s_uuid[16] to uuid_t s_uuid.

Sorry for annoying, please ignore this patch.

Thanks,

>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> fix auto-wrapping of email client
>>
>>  fs/f2fs/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 9587ca0..4d467c7 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2565,7 +2565,7 @@ static int f2fs_fill_super(struct super_block *sb,=
 void *data, int silent)
>>  	sb->s_time_gran =3D 1;
>>  	sb->s_flags =3D (sb->s_flags & ~SB_POSIXACL) |
>>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>> -	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>> +	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>>  	sb->s_iflags |=3D SB_I_CGROUPWB;
>>  =

>>  	/* init f2fs-specific super block info */
>>

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
