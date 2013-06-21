From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: reorganize the f2fs_setattr() function.
Date: Fri, 21 Jun 2013 16:30:16 +0900
Message-ID: <CAKYAXd8RQvY+-xRam2yymERAAf8oUEJ0Rznaev_ixy+xR=Ecrg@mail.gmail.com>
References: <1370694303-2738-1-git-send-email-linkinjeon@gmail.com>
	<1370824712.22405.18.camel@lcm>
	<CAKYAXd-V9iF0o5nvFyFPgJX0waDLh4c_eNJ7V_o-tbbrtX1JLQ@mail.gmail.com>
	<1370929716.14857.8.camel@lcm>
	<CAKYAXd98cgBU_JzL3zx2qT87H-XdqntdKYbCdOsx9gCeDwUO4Q@mail.gmail.com>
	<CAKYAXd_44td8BDbnuGR-ChHXjmhTnoVNq4vgujgAyAtbO6vayw@mail.gmail.com>
	<1371789772.14296.9.camel@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371789772.14296.9.camel@lcm>
Sender: linux-kernel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: jaegeuk.kim@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

>
> Sorry for late. I was very busy.
>
> Could you tell me if it happens difference between xattr and i_mode,
> what will you do?
First of all, I want to know which case make mismatching permission
between xattr and i_mode.
And when we call chmod, inode is locked in sys_chmod. If so,
inode->i_mode can be changed by any updated inode during chmod
although inode is locked ?

> The purpose of i_acl_mode is used to update i_mode and xattr together in
> same lock region.
Could you please tell me what is same lock region ? (inode->i_mutex or
mutex_lock_op(sbi))

Thanks.
>
>>
>> >
>> > ----------------------------------------------------------------------------------------------------------------
>> > Subject: [PATCH v2] f2fs: reorganize the f2fs_setattr(), f2fs_set_acl,
>> > f2fs_setxattr()
>> > From: Namjae Jeon <namjae.jeon@samsung.com>
>> >
