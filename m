From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH 1/2] f2fs: le16_to_cpu for xattr->e_value_size
Date: Sat, 11 Mar 2017 08:04:47 +0800
Message-ID: <e61731e3-3030-a3ab-7598-fca947282a27@gmail.com>
References: <20170310175335.26013-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmUWz-0002Hs-Am
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Mar 2017 00:05:09 +0000
Received: from mail-io0-f193.google.com ([209.85.223.193])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmUWy-0001hw-Ln
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Mar 2017 00:05:09 +0000
Received: by mail-io0-f193.google.com with SMTP id f103so8433049ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 16:05:08 -0800 (PST)
In-Reply-To: <20170310175335.26013-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Kinglong Mee <kinglongmee@gmail.com>

On 3/11/2017 01:53, Jaegeuk Kim wrote:
> This patch fixes missing le16 conversion, reported by kbuild test robot.
> 
> Fixes: 5f35a2cd5 ("f2fs: Don't update the xattr data that same as the exist")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Kinglong Mee <kinglongmee@gmail.com>

> ---
>  fs/f2fs/xattr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 7298a4488f7f..aff7619e3f96 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -546,7 +546,9 @@ static bool f2fs_xattr_value_same(struct f2fs_xattr_entry *entry,
>  					const void *value, size_t size)
>  {
>  	void *pval = entry->e_name + entry->e_name_len;
> -	return (entry->e_value_size == size) && !memcmp(pval, value, size);
> +
> +	return (le16_to_cpu(entry->e_value_size) == size) &&
> +					!memcmp(pval, value, size);
>  }
>  
>  static int __f2fs_setxattr(struct inode *inode, int index,
> 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
