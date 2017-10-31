From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 5/8] dump.f2fs: do not dump encrypted
 files
Date: Tue, 31 Oct 2017 15:57:43 +0800
Message-ID: <f400c643-bf4d-bca5-0598-13f114db6d19@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-5-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9RRT-0001TE-Jr
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:58:35 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e9RRS-0001pW-BB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:58:35 +0000
In-Reply-To: <20171031013824.46544-5-shengyong1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 9:38, Sheng Yong wrote:
> If a file is encrypted, its content is cipher text on the storage. So
> there is no need to dump an encrypted file.

IMO, if user have encryption key, it still has chance to read that file,
right? So how about keeping this functionality?

Thanks,

> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/dump.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 01889fd..d11e8e2 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -410,12 +410,17 @@ static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
>  	struct f2fs_inode *inode = &node_blk->i;
>  	u32 imode = le32_to_cpu(inode->i_mode);
>  	u32 namelen = le32_to_cpu(inode->i_namelen);
> -	unsigned char name[F2FS_NAME_LEN + 1] = {0};
> +	char name[F2FS_NAME_LEN + 1] = {0};
>  	char path[1024] = {0};
>  	char ans[255] = {0};
> -	int enc_name = file_enc_name(inode);
> +	int is_encrypted = file_is_encrypt(inode);
>  	int ret;
>  
> +	if (is_encrypted) {
> +		MSG(force, "File is encrypted\n");
> +		return;
> +	}
> +
>  	if (!S_ISREG(imode) || namelen == 0 || namelen > F2FS_NAME_LEN) {
>  		MSG(force, "Not a regular file or wrong name info\n\n");
>  		return;
> @@ -433,8 +438,7 @@ dump:
>  		ASSERT(ret >= 0);
>  
>  		/* make a file */
> -		namelen = convert_encrypted_name(inode->i_name, namelen,
> -							name, enc_name);
> +		strncpy(name, (const char *)inode->i_name, namelen);
>  		name[namelen] = 0;
>  		sprintf(path, "./lost_found/%s", name);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
