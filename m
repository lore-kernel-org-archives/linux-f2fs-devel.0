From: JP Abgrall <jpa@google.com>
Subject: Re: [PATCH 1/2] dump.f2fs: support dump_file from image
Date: Tue, 26 Aug 2014 16:36:58 -0700
Message-ID: <CAKP4w2Rogn8HMmi3r32Y33EwxfaZN-ke692E5ZvU8z1Ki9-F6Q@mail.gmail.com>
References: <1408486872-78010-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1XMQIm-0001oT-Cc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Aug 2014 23:37:24 +0000
Received: from mail-qg0-f42.google.com ([209.85.192.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XMQIl-0002hA-P1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Aug 2014 23:37:24 +0000
Received: by mail-qg0-f42.google.com with SMTP id j5so15757260qga.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 26 Aug 2014 16:37:18 -0700 (PDT)
In-Reply-To: <1408486872-78010-1-git-send-email-jaegeuk@kernel.org>
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

> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index 5d9b68d..46b5484 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -28,11 +28,11 @@ struct f2fs_configuration config;
>  /*
>   * IO interfaces
>   */
> -int dev_read(void *buf, __u64 offset, size_t len)
> +int dev_read(void *buf, __u64 offset, size_t len, int fd)

Don't add fd.
This makes the wrong assumption that an FD is actually the underlying
mechanism to read from the device. These IO routines are to be called
without that assumption.
Forcing it in the API here breaks the capability to read/write on
devices that are not files.
If you need to dev_read(), then setup the config appropriately.

For the rationale, see commits
  437dbf67730d2765c4dfc8539b07258e1ca3966f
 15ea79b3ae7f0474ade43ba8b6eb328806e01e15
--

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
