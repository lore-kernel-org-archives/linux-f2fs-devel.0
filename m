From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: support xattr security labels
Date: Fri, 7 Jun 2013 19:50:31 +0900
Message-ID: <CAKYAXd9V39ff3b3V13nOOH2nxZAMesMe9KzwUK-ovzBVUCkhGw@mail.gmail.com>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
	<1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
	<1370592580.3600.42.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UkuFk-0003zg-LI
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 10:50:40 +0000
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UkuFh-0002fm-EU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 10:50:40 +0000
Received: by mail-pa0-f43.google.com with SMTP id hz11so1632922pad.30
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 07 Jun 2013 03:50:31 -0700 (PDT)
In-Reply-To: <1370592580.3600.42.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

2013/6/7, Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> Change log from v1:
>  o fix a bug
>
> From 901aea226653e26aa3556edd88ca1e48fa89eb5f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Date: Mon, 3 Jun 2013 19:46:19 +0900
> Subject: [PATCH 2/2] f2fs: support xattr security labels
> Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
> linux-f2fs-devel@lists.sourceforge.net
>
> This patch adds the support of security labels for f2fs, which will be used
> by SElinux.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/Kconfig |  9 +++++++++
>  fs/f2fs/dir.c   |  5 +++++
>  fs/f2fs/xattr.c | 60
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/f2fs/xattr.h | 12 +++++++++++-
>  4 files changed, 83 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> index fd27e7e..2214cc9 100644
> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -51,3 +51,12 @@ config F2FS_FS_POSIX_ACL
>  	  Linux website <http://acl.bestbits.at/>.
>
>  	  If you don't know what Access Control Lists are, say N
> +
> +config F2FS_FS_SECURITY
> +	bool "F2FS Security Labels"
> +	depends on F2FS_FS_XATTR
Hi Jaegeuk.
Do we need to add "default y" as other xattr options ?

Thanks.
> +	help
> +	  Security labels provide acls used by the security modules
> +	  like SELinux. This option should be used with the xattr mode.
> +
> +	  If you are not using a security module, say N.

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
