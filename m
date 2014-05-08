From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][PATCH 6/6] f2fs: add a tracepoint for
 f2fs_read_data_pages
Date: Thu, 08 May 2014 16:58:57 +0800
Message-ID: <000001cf6a9b$d9d14740$8d73d5c0$@samsung.com>
References: <004801cf6908$e2149bd0$a63dd370$@samsung.com>
 <1399422592.13268.15.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1399422592.13268.15.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kim,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Wednesday, May 07, 2014 8:30 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel=
=2Eorg;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 6/6] f2fs: add a tracepoint for f2fs_re=
ad_data_pages
>=20
> Hi Chao,
>=20
> 2014-05-06 (=ED=99=94), 16:54 +0800, Chao Yu:
> > This patch adds a tracepoint for f2fs_read_data_pages to trace when=
 pages are
> > readahead by VFS.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c              |    3 +++
> >  include/trace/events/f2fs.h |   26 ++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 8c250a5..f2d1e8a 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -729,6 +729,9 @@ static int f2fs_read_data_pages(struct file *fi=
le,
> >  			struct list_head *pages, unsigned nr_pages)
> >  {
> >  	struct inode *inode =3D file->f_mapping->host;
> > +	struct page *page =3D list_entry(pages->prev, struct page, lru);
>=20
> IMO, it needs to avoid the above line.

Maybe it=E2=80=99s not safe to access page directly in lru list here.
Let's ignore this patch.
Thanks.

> Thanks,
>=20
> > +
> > +	trace_f2fs_readpages(inode, page, nr_pages);
> >
> >  	/* If the file has inline data, skip readpages */
> >  	if (f2fs_has_inline_data(inode))
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2f=
s.h
> > index b983990..7fbaaaa 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -847,6 +847,32 @@ TRACE_EVENT(f2fs_writepages,
> >  		__entry->for_sync)
> >  );
> >
> > +TRACE_EVENT(f2fs_readpages,
> > +
> > +	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrp=
age),
> > +
> > +	TP_ARGS(inode, page, nrpage),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(dev_t,	dev)
> > +		__field(ino_t,	ino)
> > +		__field(pgoff_t,	start)
> > +		__field(unsigned int,	nrpage)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev	=3D inode->i_sb->s_dev;
> > +		__entry->ino	=3D inode->i_ino;
> > +		__entry->start	=3D page->index;
> > +		__entry->nrpage	=3D nrpage;
> > +	),
> > +
> > +	TP_printk("dev =3D (%d,%d), ino =3D %lu, start =3D %lu nrpage =3D=
 %u",
> > +		show_dev_ino(__entry),
> > +		(unsigned long)__entry->start,
> > +		__entry->nrpage)
> > +);
> > +
> >  TRACE_EVENT(f2fs_submit_page_mbio,
> >
> >  	TP_PROTO(struct page *page, int rw, int type, block_t blk_addr),
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
