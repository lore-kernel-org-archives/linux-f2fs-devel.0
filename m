From: Andrey Tsyvarev <tsyvarev@ispras.ru>
Subject: Re: f2fs: f2fs unmount hangs if f2fs_init_acl() fails
 during mkdir syscall
Date: Thu, 13 Feb 2014 13:40:37 +0400
Message-ID: <52FC9315.2090707@ispras.ru>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
	<52F37D67.208@ispras.ru> <1391734185.25542.80.camel@kjgkr>
	<1391749933.25542.83.camel@kjgkr> <52F9DF85.7040402@ispras.ru>
	<52FC832F.6000103@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tsyvarev@ispras.ru>) id 1WDsml-0000Jb-1J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 09:40:47 +0000
Received: from smtp.ispras.ru ([83.149.199.79])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDsmj-0005oK-2L for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 09:40:46 +0000
In-Reply-To: <52FC832F.6000103@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi,

> BTW, have you tested the case that added remove_dirty_dir_inode() into the fail path
> of init_inode_metadata?
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index e095a4f..d5a2c9e 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -375,6 +375,7 @@ put_error:
>          /* once the failed inode becomes a bad inode, i_mode is S_IFREG */
>          truncate_inode_pages(&inode->i_data, 0);
>          truncate_blocks(inode, 0);
> +       remove_dirty_dir_inode(inode);
>   error:
>          remove_inode_page(inode);
>          return ERR_PTR(err);
Yes, i have tested that case. Fail in init_inode_metadata has been 
processed correctly. Thanks.

-- 
Best regards,

Andrey Tsyvarev

Linux Verification Center, ISPRAS

web:http://linuxtesting.org


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
