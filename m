From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev][PATCH 3/3 v3] f2fs: fix to truncate inline data in
 inode page when setattr
Date: Tue, 29 Apr 2014 15:16:14 +0900
Message-ID: <1398752174.13268.4.camel@kjgkr>
References: <001801cf6370$e0553040$a0ff90c0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <001801cf6370$e0553040$a0ff90c0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2014-04-29 (=ED=99=94), 14:03 +0800, Chao Yu:
> Previous we do not truncate inline data in inode page when setattr, s=
o following
> case could still read the inline data which has already truncated:
>=20
> 1.write inline data
> 2.ftruncate size to 0
> 3.ftruncate size to max inline data size
> 4.read from offset 0
>=20
> This patch introduces truncate_inline_data() to fix this problem.
>=20
> change log from v1:
>  o fix a bug and do not truncate first page data after truncate inlin=
e data.
> change log from v2:
>  o wait to writeback for inode page if it was already submitted.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/f2fs.h   |    1 +
>  fs/f2fs/file.c   |    3 +++
>  fs/f2fs/inline.c |   19 +++++++++++++++++++
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2b67679..676a2c6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1410,5 +1410,6 @@ bool f2fs_may_inline(struct inode *);
>  int f2fs_read_inline_data(struct inode *, struct page *);
>  int f2fs_convert_inline_data(struct inode *, pgoff_t);
>  int f2fs_write_inline_data(struct inode *, struct page *, unsigned i=
nt);
> +void truncate_inline_data(struct inode *, u64);
>  int recover_inline_data(struct inode *, struct page *);
>  #endif
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b9f4fbf..d97e5c4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -369,6 +369,9 @@ static void truncate_partial_data_page(struct ino=
de *inode, u64 from)
>  	unsigned offset =3D from & (PAGE_CACHE_SIZE - 1);
>  	struct page *page;
> =20
> +	if (f2fs_has_inline_data(inode))
> +		return truncate_inline_data(inode, from);
> +
>  	if (!offset)
>  		return;
> =20
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 3258c7c..6a13997 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -176,6 +176,25 @@ int f2fs_write_inline_data(struct inode *inode,
>  	return 0;
>  }
> =20
> +void truncate_inline_data(struct inode *inode, u64 from)
> +{
> +	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> +	struct page *ipage;
> +
> +	if (from >=3D MAX_INLINE_DATA)
> +		return;
> +
> +	ipage =3D get_node_page(sbi, inode->i_ino);
> +	if (IS_ERR(ipage))
> +		return;
> +
> +	f2fs_wait_on_page_writeback(ipage, NODE);

The get_node_page() triggers,
 grab_cache_page_write_begin()
  -> wait_for_stable_page()
     -> wait_on_page_writeback().

Any bugs in there?

> +	zero_user_segment(ipage, INLINE_DATA_OFFSET + from,
> +				INLINE_DATA_OFFSET + MAX_INLINE_DATA);
> +	set_page_dirty(ipage);
> +	f2fs_put_page(ipage, 1);
> +}
> +
>  int recover_inline_data(struct inode *inode, struct page *npage)
>  {
>  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);

--=20
Jaegeuk Kim
Samsung
