From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH RESEND 1/2] mkfs.f2fs: support large sector
	size
Date: Fri, 6 Feb 2015 08:42:44 +0800
Message-ID: <CAB6yy349NJJMhQCBT3myt7wvCDnXd56YV3w_zGe+1pLA5D+pqw@mail.gmail.com>
References: <006201d04127$6f254d70$4d6fe850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1YJX0V-0004im-Fs
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Feb 2015 00:42:51 +0000
Received: from mail-wg0-f50.google.com ([74.125.82.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YJX0U-00045J-MV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Feb 2015 00:42:51 +0000
Received: by mail-wg0-f50.google.com with SMTP id b13so10569658wgh.9
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 05 Feb 2015 16:42:44 -0800 (PST)
In-Reply-To: <006201d04127$6f254d70$4d6fe850$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Thu, Feb 5, 2015 at 5:36 PM, Chao Yu <chao2.yu@samsung.com> wrote:
> Since f2fs support large sector size in commit 55cf9cb63f0e "f2fs: support large
> sector size", block device with sector size of 512/1024/2048/4096 bytes can be
> supported.
>
> But mkfs.f2fs still use default sector size: 512 bytes as sector size, let's fix
> this issue in this patch.
>
> v2:
>  o remove unneeded printed message when sector size is large than 512 bytes
>    suggested by Kinglong.
>  o show correct sector size in printed message.
>  o use config.sectors_per_blk instead of DEFAULT_SECTORS_PER_BLOCK suggested by
>    Kinglong.
> v3:
>  o remove another unneeded printed message when sector size is large than 512
>    bytes suggested by Kinglong.
>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>

Reviewed-by: Kinglong Mee <kinglongmee@gmail.com>

thanks,
Kinglong Mee

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
