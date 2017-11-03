From: =?GB2312?B?y87UxsH6?= <yunlong.song@icloud.com>
Subject: Re: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails to get one
 victim
Date: Fri, 03 Nov 2017 23:08:23 +0800
Message-ID: <3E42CE2B-DC94-47C2-8AD3-76ECD95F10E3@icloud.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <20171103034402.GC11335@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171103034402.GC11335@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yunlong Song <yunlong.song@huawei.com>, chao@kernel.org, yuchao0@huawei.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

OK to me.

>=20
>=20
>> On 10/13, Yunlong Song wrote:
>> This can help us to debug on some corner case.
>>=20
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> fs/f2fs/gc.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 197ebf4..2b03202 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>        .ilist =3D LIST_HEAD_INIT(gc_list.ilist),
>>        .iroot =3D RADIX_TREE_INIT(GFP_NOFS),
>>    };
>> +    bool need_fggc =3D false;
>>=20
>>    trace_f2fs_gc_begin(sbi->sb, sync, background,
>>                get_pages(sbi, F2FS_DIRTY_NODES),
>> @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>            if (ret)
>>                goto stop;
>>        }
>> -        if (has_not_enough_free_secs(sbi, 0, 0))
>> +        if (has_not_enough_free_secs(sbi, 0, 0)) {
>>            gc_type =3D FG_GC;
>> +            need_fggc =3D true;
>> +        }
>>    }
>>=20
>>    /* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>> @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>        goto stop;
>>    }
>>    if (!__get_victim(sbi, &segno, gc_type)) {
>> +        f2fs_bug_on(sbi, !total_freed && need_fggc);
>=20
> Just like this?
>=20
>        f2fs_bug_on(sbi, !total_freed && !sync && gc_type =3D=3D FG_GC)=A3=BB=


Agree

>=20
>>        ret =3D -ENODATA;
>>        goto stop;
>>    }
>> --=20
>> 1.8.5.2
