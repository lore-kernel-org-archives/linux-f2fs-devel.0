From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 01/10] fs crypto: add basic definitions for per-file
 encryption
Date: Fri, 11 Mar 2016 10:50:20 -0800
Message-ID: <20160311185020.GA62857@jaegeuk.gateway>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
 <1456428368-41527-2-git-send-email-jaegeuk@kernel.org>
 <56D3DA02.4010705@infradead.org>
 <20160301013536.GA60850@jaegeuk.hsd1.ca.comcast.net>
 <CAA9_cmfCU1piC9wQr0z=z7gHEmOOEiZu595JOJHod2Y1EgDw8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAA9_cmfCU1piC9wQr0z=z7gHEmOOEiZu595JOJHod2Y1EgDw8Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Dan,

On Thu, Mar 10, 2016 at 09:00:25PM -0800, Dan Williams wrote:
> On Mon, Feb 29, 2016 at 5:35 PM, Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
> > On Sun, Feb 28, 2016 at 09:41:22PM -0800, Randy Dunlap wrote:
> >> On 02/25/16 11:25, Jaegeuk Kim wrote:
> >> > This patch adds definitions for per-file encryption used by ext4=
 and f2fs.
> >> >
> >> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >> > ---
> >> >  include/linux/fs.h       |   8 ++
> >> >  include/linux/fscrypto.h | 239 ++++++++++++++++++++++++++++++++=
+++++++++++++++
> >> >  include/uapi/linux/fs.h  |  18 ++++
> >> >  3 files changed, 265 insertions(+)
> >> >  create mode 100644 include/linux/fscrypto.h
> >> >
> >> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> > index ae68100..d8f57cf 100644
> >> > --- a/include/linux/fs.h
> >> > +++ b/include/linux/fs.h
> >> > @@ -53,6 +53,8 @@ struct swap_info_struct;
> >> >  struct seq_file;
> >> >  struct workqueue_struct;
> >> >  struct iov_iter;
> >> > +struct fscrypt_info;
> >> > +struct fscrypt_operations;
> >> >
> >> >  extern void __init inode_init(void);
> >> >  extern void __init inode_init_early(void);
> >> > @@ -678,6 +680,10 @@ struct inode {
> >> >     struct hlist_head       i_fsnotify_marks;
> >> >  #endif
> >> >
> >> > +#ifdef CONFIG_FS_ENCRYPTION
> >> > +   struct fscrypt_info     *i_crypt_info;
> >> > +#endif
> >> > +
> >> >     void                    *i_private; /* fs or device private =
pointer */
> >> >  };
> >> >
> >> > @@ -1323,6 +1329,8 @@ struct super_block {
> >> >  #endif
> >> >     const struct xattr_handler **s_xattr;
> >> >
> >> > +   const struct fscrypt_operations *s_cop;
> >> > +
> >> >     struct hlist_bl_head    s_anon;         /* anonymous dentrie=
s for (nfs) exporting */
> >> >     struct list_head        s_mounts;       /* list of mounts; _=
not_ for fs use */
> >> >     struct block_device     *s_bdev;
> >> > diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
> >> > new file mode 100644
> >> > index 0000000..b0aed92
> >> > --- /dev/null
> >> > +++ b/include/linux/fscrypto.h
> >> > @@ -0,0 +1,239 @@
> >> > +/*
> >> > + * General per-file encryption definition
> >> > + *
> >> > + * Copyright (C) 2015, Google, Inc.
> >> > + *
> >> > + * Written by Michael Halcrow, 2015.
> >> > + * Modified by Jaegeuk Kim, 2015.
> >> > + */
> >> > +
> >> > +#ifndef _LINUX_FSCRYPTO_H
> >> > +#define _LINUX_FSCRYPTO_H
> >> > +
> >> > +#include <linux/key.h>
> >> > +#include <linux/fs.h>
> >> > +#include <linux/mm.h>
> >> > +#include <linux/bio.h>
> >> > +#include <linux/dcache.h>
> >> > +#include <uapi/linux/fs.h>
> >> > +
> >> > +#define FS_KEY_DERIVATION_NONCE_SIZE               16
> >> > +#define FS_ENCRYPTION_CONTEXT_FORMAT_V1            1
> >> > +
> >> > +#define FS_POLICY_FLAGS_PAD_4              0x00
> >> > +#define FS_POLICY_FLAGS_PAD_8              0x01
> >> > +#define FS_POLICY_FLAGS_PAD_16             0x02
> >> > +#define FS_POLICY_FLAGS_PAD_32             0x03
> >> > +#define FS_POLICY_FLAGS_PAD_MASK   0x03
> >> > +#define FS_POLICY_FLAGS_VALID              0x03
> >> > +
> >> > +/* Encryption algorithms */
> >> > +#define FS_ENCRYPTION_MODE_INVALID         0
> >> > +#define FS_ENCRYPTION_MODE_AES_256_XTS             1
> >> > +#define FS_ENCRYPTION_MODE_AES_256_GCM             2
> >> > +#define FS_ENCRYPTION_MODE_AES_256_CBC             3
> >> > +#define FS_ENCRYPTION_MODE_AES_256_CTS             4
> >> > +
> >> > +/**
> >> > + * Encryption context for inode
> >> > + *
> >> > + * Protector format:
> >> > + *  1 byte: Protector format (1 =3D this version)
> >> > + *  1 byte: File contents encryption mode
> >> > + *  1 byte: File names encryption mode
> >> > + *  1 byte: Flags
> >> > + *  8 bytes: Master Key descriptor
> >> > + *  16 bytes: Encryption Key derivation nonce
> >> > + */
> >> > +struct fscrypt_context {
> >> > +   char format;
> >> > +   char contents_encryption_mode;
> >> > +   char filenames_encryption_mode;
> >> > +   char flags;
> >> > +   char master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
> >> > +   char nonce[FS_KEY_DERIVATION_NONCE_SIZE];
> >>
> >> how about u8 instead of char?
> >
> > It seems that it needs to user u8 instead of char for other variabl=
es as well.
> > I'll take a look at all the usages.
>=20
> I think it needs to be __u8 otherwise I get this in a userspace progr=
am:
>=20
> In file included from test/blk_namespaces.c:17:0:
> /usr/include/linux/fs.h:256:2: error: unknown type name =E2=80=98u8=E2=
=80=99
>   u8 version;
>   ^
> /usr/include/linux/fs.h:257:2: error: unknown type name =E2=80=98u8=E2=
=80=99
>   u8 contents_encryption_mode;
>   ^
> /usr/include/linux/fs.h:258:2: error: unknown type name =E2=80=98u8=E2=
=80=99
>   u8 filenames_encryption_mode;
>   ^
> /usr/include/linux/fs.h:259:2: error: unknown type name =E2=80=98u8=E2=
=80=99
>   u8 flags;
>   ^
> /usr/include/linux/fs.h:260:2: error: unknown type name =E2=80=98u8=E2=
=80=99
>   u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
>   ^

I realized that it needs to use __u8 as an exportable data type which c=
an be
seen by user-space programs.

So, IMO, only fscrypt_policy should be exportable, and other structures=
 need
to use u8.

Let me know, if I'm missing something.

Thanks,
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
