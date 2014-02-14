From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] f2fs: f2fs unmount hangs if f2fs_init_acl() fails
 during mkdir syscall
Date: Fri, 14 Feb 2014 11:00:10 +0900
Message-ID: <1392343210.25542.115.camel@kjgkr>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
 <52F37D67.208@ispras.ru> <1391734185.25542.80.camel@kjgkr>
 <1391749933.25542.83.camel@kjgkr> <52F9DF85.7040402@ispras.ru>
 <52FC832F.6000103@cn.fujitsu.com> <52FC9315.2090707@ispras.ru>
 <52FC94D0.2050705@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <52FC94D0.2050705@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Andrey Tsyvarev <tsyvarev@ispras.ru>, linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2014-02-13 (=EB=AA=A9), 17:48 +0800, Gu Zheng:
> Hi,
> On 02/13/2014 05:40 PM, Andrey Tsyvarev wrote:
>=20
> > Hi,
> >=20
> >> BTW, have you tested the case that added remove_dirty_dir_inode() =
into the fail path
> >> of init_inode_metadata?
> >> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >> index e095a4f..d5a2c9e 100644
> >> --- a/fs/f2fs/dir.c
> >> +++ b/fs/f2fs/dir.c
> >> @@ -375,6 +375,7 @@ put_error:
> >>          /* once the failed inode becomes a bad inode, i_mode is S=
_IFREG */
> >>          truncate_inode_pages(&inode->i_data, 0);
> >>          truncate_blocks(inode, 0);
> >> +       remove_dirty_dir_inode(inode);
> >>   error:
> >>          remove_inode_page(inode);
> >>          return ERR_PTR(err);
> > Yes, i have tested that case. Fail in init_inode_metadata has been =
processed correctly. Thanks.
>=20
> If no other regressions, maybe you can send out the fix patch about t=
his issue.:)

The original patch can treat this too.
Thank you. :)

>=20
> Thanks,
> Gu
>=20
> >=20
>=20
>=20

--=20
Jaegeuk Kim
Samsung
