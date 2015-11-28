From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH V2 1/2] mkfs.f2fs: add helper strtrim()
 to trim string's space
Date: Sat, 28 Nov 2015 11:53:36 +0800
Message-ID: <56592540.6070806@kernel.org>
References: <1448705988-29484-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1a2Wa4-000646-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 03:53:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a2Wa3-0001FL-0O for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 03:53:48 +0000
In-Reply-To: <1448705988-29484-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 11/28/15 6:19 PM, Sheng Yong wrote:
> Add a helper function strtrim() to trim space both at the beginning and end
> of a string.

I'm not sure we should add more logic when processing user defined extension string.

How about waiting for Jaegeuk's opinion?

Thanks,

> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  include/f2fs_fs.h |  1 +
>  lib/libf2fs.c     | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 359deec..e85b2d0 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -768,6 +768,7 @@ enum {
>  
>  extern void ASCIIToUNICODE(u_int16_t *, u_int8_t *);
>  extern int log_base_2(u_int32_t);
> +extern void strtrim(char **str);
>  extern unsigned int addrs_per_inode(struct f2fs_inode *);
>  
>  extern int get_bits_in_byte(unsigned char n);
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 83d1296..e901289 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -48,6 +48,30 @@ int log_base_2(u_int32_t num)
>  	return ret;
>  }
>  
> +void strtrim(char **str)
> +{
> +	int len = strlen(*str);
> +	char *head = *str;
> +	char *tail = *str + len - 1;
> +
> +	while (head != tail) {
> +		if (*head == ' ')
> +			head++;
> +		else {
> +			*str = head;
> +			break;
> +		}
> +	}
> +
> +	while (tail != head) {
> +		if (*tail == ' ') {
> +			*tail = '\0';
> +			tail--;
> +		} else
> +			break;
> +	}
> +}
> +
>  /*
>   * f2fs bit operations
>   */
> 

------------------------------------------------------------------------------
