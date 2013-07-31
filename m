From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: add a wait step when submit bio with {READ,WRITE}_SYNC
Date: Wed, 31 Jul 2013 18:09:49 +0800
Message-ID: <51F8E26D.2070907@cn.fujitsu.com>
References: <51F7901E.3010204@cn.fujitsu.com> <1375187398.26443.69.camel@kjgkr> <51F86F67.1070605@cn.fujitsu.com> <1375265195.26443.78.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375265195.26443.78.camel@kjgkr>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/31/2013 06:06 PM, Jaegeuk Kim wrote:

> 2013-07-31 (=EC=88=98), 09:59 +0800, Gu Zheng:
>> Hi Kim,
>>
>> On 07/30/2013 08:29 PM, Jaegeuk Kim wrote:
>>
>>> Hi Gu,
>>>
>>> The original read flow was to avoid redandunt lock/unlock_page() ca=
lls.
>>
>> Right, this can gain better read performance. But is the wait step a=
fter=20
>> submitting bio with READ_SYNC needless too?
>=20
> Correct, the READ_SYNC is also used for IO priority.
> The basic read policy here is that the caller should lock the page on=
ly
> when it wants to manipulate there-in data.

> Otherwise, we don't need to unnecessary lock and unlocks.

Got it, it seems that I had some miss reading originally, it's
clear now, thanks very much for your explanation.:)

Regards,
Gu

> Thanks,

>=20
>>
>>> And we should not wait for WRITE_SYNC, since it is just for write
>>> priority, not for synchronization of the file system.
>>
>> Got it, thanks for your explanation.:)=20
>>
>> Best regards,
>> Gu
>>
>>> Thanks,
>>>
>>> 2013-07-30 (=ED=99=94), 18:06 +0800, Gu Zheng:
>>>> When we submit bio with READ_SYNC or WRITE_SYNC, we need to wait a
>>>> moment for the io completion, current codes only find_data_page() =
follows the
>>>> rule, other places missing this step, so add it.
>>>>
>>>> Further more, moving the PageUptodate check into f2fs_readpage() t=
o clean up
>>>> the codes.
>>>>
>>>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>>>> ---
>>>>  fs/f2fs/checkpoint.c |    1 -
>>>>  fs/f2fs/data.c       |   39 +++++++++++++++++--------------------=
--
>>>>  fs/f2fs/node.c       |    1 -
>>>>  fs/f2fs/recovery.c   |    2 --
>>>>  fs/f2fs/segment.c    |    2 +-
>>>>  5 files changed, 18 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index fe91773..e376a42 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -64,7 +64,6 @@ repeat:
>>>>  	if (f2fs_readpage(sbi, page, index, READ_SYNC))
>>>>  		goto repeat;
>>>> =20
>>>> -	lock_page(page);
>>>>  	if (page->mapping !=3D mapping) {
>>>>  		f2fs_put_page(page, 1);
>>>>  		goto repeat;
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 19cd7c6..b048936 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -216,13 +216,11 @@ struct page *find_data_page(struct inode *in=
ode, pgoff_t index, bool sync)
>>>> =20
>>>>  	err =3D f2fs_readpage(sbi, page, dn.data_blkaddr,
>>>>  					sync ? READ_SYNC : READA);
>>>> -	if (sync) {
>>>> -		wait_on_page_locked(page);
>>>> -		if (!PageUptodate(page)) {
>>>> -			f2fs_put_page(page, 0);
>>>> -			return ERR_PTR(-EIO);
>>>> -		}
>>>> -	}
>>>> +	if (err)
>>>> +		return ERR_PTR(err);
>>>> +
>>>> +	if (sync)
>>>> +		unlock_page(page);
>>>>  	return page;
>>>>  }
>>>> =20
>>>> @@ -267,11 +265,6 @@ repeat:
>>>>  	if (err)
>>>>  		return ERR_PTR(err);
>>>> =20
>>>> -	lock_page(page);
>>>> -	if (!PageUptodate(page)) {
>>>> -		f2fs_put_page(page, 1);
>>>> -		return ERR_PTR(-EIO);
>>>> -	}
>>>>  	if (page->mapping !=3D mapping) {
>>>>  		f2fs_put_page(page, 1);
>>>>  		goto repeat;
>>>> @@ -325,11 +318,7 @@ repeat:
>>>>  		err =3D f2fs_readpage(sbi, page, dn.data_blkaddr, READ_SYNC);
>>>>  		if (err)
>>>>  			return ERR_PTR(err);
>>>> -		lock_page(page);
>>>> -		if (!PageUptodate(page)) {
>>>> -			f2fs_put_page(page, 1);
>>>> -			return ERR_PTR(-EIO);
>>>> -		}
>>>> +
>>>>  		if (page->mapping !=3D mapping) {
>>>>  			f2fs_put_page(page, 1);
>>>>  			goto repeat;
>>>> @@ -399,6 +388,16 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, s=
truct page *page,
>>>> =20
>>>>  	submit_bio(type, bio);
>>>>  	up_read(&sbi->bio_sem);
>>>> +
>>>> +	if (type =3D=3D READ_SYNC) {
>>>> +		wait_on_page_locked(page);
>>>> +		lock_page(page);
>>>> +		if (!PageUptodate(page)) {
>>>> +			f2fs_put_page(page, 1);
>>>> +			return -EIO;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> @@ -679,11 +678,7 @@ repeat:
>>>>  		err =3D f2fs_readpage(sbi, page, dn.data_blkaddr, READ_SYNC);
>>>>  		if (err)
>>>>  			return err;
>>>> -		lock_page(page);
>>>> -		if (!PageUptodate(page)) {
>>>> -			f2fs_put_page(page, 1);
>>>> -			return -EIO;
>>>> -		}
>>>> +
>>>>  		if (page->mapping !=3D mapping) {
>>>>  			f2fs_put_page(page, 1);
>>>>  			goto repeat;
>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>> index f5172e2..f061554 100644
>>>> --- a/fs/f2fs/node.c
>>>> +++ b/fs/f2fs/node.c
>>>> @@ -1534,7 +1534,6 @@ int restore_node_summary(struct f2fs_sb_info=
 *sbi,
>>>>  		if (f2fs_readpage(sbi, page, addr, READ_SYNC))
>>>>  			goto out;
>>>> =20
>>>> -		lock_page(page);
>>>>  		rn =3D F2FS_NODE(page);
>>>>  		sum_entry->nid =3D rn->footer.nid;
>>>>  		sum_entry->version =3D 0;
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index 639eb34..ec68183 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -140,8 +140,6 @@ static int find_fsync_dnodes(struct f2fs_sb_in=
fo *sbi, struct list_head *head)
>>>>  		if (err)
>>>>  			goto out;
>>>> =20
>>>> -		lock_page(page);
>>>> -
>>>>  		if (cp_ver !=3D cpver_of_node(page))
>>>>  			break;
>>>> =20
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 9b74ae2..bcd19db 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -639,7 +639,7 @@ static void do_submit_bio(struct f2fs_sb_info =
*sbi,
>>>> =20
>>>>  		trace_f2fs_do_submit_bio(sbi->sb, btype, sync, sbi->bio[btype])=
;
>>>> =20
>>>> -		if (type =3D=3D META_FLUSH) {
>>>> +		if ((type =3D=3D META_FLUSH) || (rw & WRITE_SYNC)) {
>>>>  			DECLARE_COMPLETION_ONSTACK(wait);
>>>>  			p->is_sync =3D true;
>>>>  			p->wait =3D &wait;
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsde=
vel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
