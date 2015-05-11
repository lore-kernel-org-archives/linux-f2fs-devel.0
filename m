From: hujianyang <hujianyang@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 14/18] f2fs crypto: add filename encryption
 for f2fs_lookup
Date: Mon, 11 May 2015 14:38:16 +0800
Message-ID: <55504E58.9060203@huawei.com>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org> <1431145253-2019-14-git-send-email-jaegeuk@kernel.org> <55501980.7040206@huawei.com> <20150511051249.GA7675@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150511051249.GA7675@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

It's OK now.

Thanks,
Hu

On 2015/5/11 13:12, Jaegeuk Kim wrote:
> Hi Hujianynag,
>=20
> I just fixed it up, and rebased the dev branch.
> Could you check them out?
>=20
> Thanks,
>=20
> On Mon, May 11, 2015 at 10:52:48AM +0800, hujianyang wrote:
>> Hi Jaegeuk,
>>
>> While compiling git://git.kernel.org/pub/scm/linux/kernel/git/jaegeu=
k/f2fs.git
>> branch dev(commit 5af6e74892a f2fs crypto: remove checking key conte=
xt during lookup),
>> I saw an error:
>>
>> fs/f2fs/dir.c: In function =E2=80=98find_in_level=E2=80=99:
>> fs/f2fs/dir.c:163: error: unknown field =E2=80=98len=E2=80=99 specif=
ied in initializer
>> fs/f2fs/dir.c:163: warning: excess elements in struct initializer
>> fs/f2fs/dir.c:163: warning: (near initialization for =E2=80=98name=E2=
=80=99)
>>
>> I think it's related to this patch.
>> If there is anything wrong in my configuration, please let me know.
>>
>> Thanks,
>> Hu
>>
