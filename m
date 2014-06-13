From: JP Abgrall <jpa@google.com>
Subject: Re: [PATCH] libf2fs, fsck,
 mkfs: call f2fs_finalize_device before exit
Date: Fri, 13 Jun 2014 12:23:14 -0700
Message-ID: <CAKP4w2RNKx+s=6eHuo27T4=Hn25B=jdTarv=3-hRnTTnuqifbw@mail.gmail.com>
References: <1402647925-79429-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1WvX4g-0005Ww-27
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 19:23:42 +0000
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WvX4e-0001vX-A5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 19:23:42 +0000
Received: by mail-oa0-f46.google.com with SMTP id m1so3335068oag.5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 13 Jun 2014 12:23:34 -0700 (PDT)
In-Reply-To: <1402647925-79429-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Jun 13, 2014 at 1:25 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 6168c5c..8d6c670 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -493,3 +493,15 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>         return 0;
>  }
>
> +void f2fs_finalize_device(struct f2fs_configuration *c)
> +{
> +       /*
> +        * We should call fsync() to flush out all the dirty pages
> +        * in the block device page cache.
> +        */
> +       if (fsync(c->fd) < 0)
> +               MSG(0, "\tError: Could not conduct fsync!!!\n");
> +
> +       if (close(c->fd) < 0)
> +               MSG(0, "\tError: Failed to close device file!!!\n");
> +}

This might be better in lib/libf2fs_io.c.

It should stay outside of libf2fs otherwise it prevents building code
that works on something else that an fd which supports fsync/close/...
Currently libf2fs is device agnostic: I'm able to use it against
Android's libsparse by linking against a lib that provides stubs for
everything in f2fs_format_utils.c and lib/libf2fs_io.c.

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
