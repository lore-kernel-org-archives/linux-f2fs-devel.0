From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH 1/2] dump/fsck: convert encrypted file name
Date: Mon, 24 Oct 2016 11:47:06 +0800
Message-ID: <580D843A.3000208@huawei.com>
References: <20161024021604.5218-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1byWEr-0002Av-0b
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 03:47:53 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1byWEl-0006Db-Vu
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 03:47:52 +0000
In-Reply-To: <20161024021604.5218-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

Hi, Jaegeuk,

On 10/24/2016 10:16 AM, Sheng Yong wrote:
> If fscrypt is enabled, we need to convert the encrypted file name before
> printing it. So let's export convert_encrypted_name for other functions,
> and make it returns the length of converted string.
> This patch also changes the parameter of file_is_encrypt to f2fs_inode.
> 
[...]
> -static void convert_encrypted_name(unsigned char *name, int len,
> +int convert_encrypted_name(unsigned char *name, int len,
>  				unsigned char *new, int encrypted)
>  {
>  	if (!encrypted) {
>  		memcpy(new, name, len);
>  		new[len] = 0;
> -		return;
> +		return len;
>  	}
>  
>  	*new = '_';
> -	digest_encode((const char *)name, 24, (char *)new + 1);
> +	return digest_encode((const char *)name, 24, (char *)new + 1);
I'm confused about the parameter "24" here. Why it is not the length of
the cipher text?

thanks,
Sheng
>  }
[...]


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
