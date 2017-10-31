From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 4/8] dump.f2fs: introduce dump_xattr
Date: Tue, 31 Oct 2017 15:51:32 +0800
Message-ID: <91948c76-3a3f-b1c9-1a37-d0c66ef0b393@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-4-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9RLk-00070d-8h
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:52:40 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9RLi-0006D9-WA
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:52:40 +0000
In-Reply-To: <20171031013824.46544-4-shengyong1@huawei.com>
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
> This patch introduces dump_xattr to create xattrs for dumped files.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/dump.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 90fd073..01889fd 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -11,6 +11,9 @@
>  #include <inttypes.h>
>  
>  #include "fsck.h"
> +#include "xattr.h"
> +#include <attr/xattr.h>
> +#include <linux/xattr.h>
>  #include <locale.h>
>  
>  #define BUF_SZ	80
> @@ -310,15 +313,67 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
>  	free(node_blk);
>  }
>  
> +static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk)
> +{
> +	void *xattr;
> +	struct f2fs_xattr_entry *ent;
> +	char xattr_name[F2FS_NAME_LEN] = {0};
> +	int ret;
> +
> +	xattr = read_all_xattrs(sbi, node_blk);
> +
> +	list_for_each_xattr(ent, xattr) {
> +		char *name = strndup(ent->e_name, ent->e_name_len);
> +		void *value = ent->e_name + ent->e_name_len;
> +
> +		if (!name)
> +			continue;
> +
> +		switch (ent->e_name_index) {
> +		case F2FS_XATTR_INDEX_USER:
> +			ret = snprintf(xattr_name, F2FS_NAME_LEN, "%s%s",
> +				       XATTR_USER_PREFIX, name);
> +			break;
> +
> +		case F2FS_XATTR_INDEX_SECURITY:
> +			ret = snprintf(xattr_name, F2FS_NAME_LEN, "%s%s",
> +				       XATTR_SECURITY_PREFIX, name);
> +			break;
> +		case F2FS_XATTR_INDEX_TRUSTED:
> +			ret = snprintf(xattr_name, F2FS_NAME_LEN, "%s%s",
> +				       XATTR_TRUSTED_PREFIX, name);
> +			break;
> +		default:
> +			MSG(0, "Unknown xattr index 0x%x\n", ent->e_name_index);
> +			free(name);
> +			continue;
> +		}
> +		if (ret >= F2FS_NAME_LEN) {
> +			MSG(0, "XATTR index 0x%x name too long\n", ent->e_name_index);
> +			free(name);
> +			continue;
> +		}
> +
> +		DBG(1, "fd %d xattr_name %s\n", c.dump_fd, xattr_name);
> +		ret = fsetxattr(c.dump_fd, xattr_name, value,
> +				le16_to_cpu(ent->e_value_size), XATTR_CREATE);
> +		if (ret)

if (ret == -EEXIST)
	fsetxattr(,,,,XATTR_REPLACE)?

Thanks,

> +			MSG(0, "XATTR index 0x%x set xattr failed error %d\n",
> +			    ent->e_name_index, errno);
> +
> +		free(name);
> +	}
> +
> +	free(xattr);
> +}
> +
>  static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  					struct f2fs_node *node_blk)
>  {
>  	u32 i = 0;
>  	u64 ofs = 0;
>  
> -	/* TODO: need to dump xattr */
> -
> -	if((node_blk->i.i_inline & F2FS_INLINE_DATA)){
> +	if((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
>  		DBG(3, "ino[0x%x] has inline data!\n", nid);
>  		/* recover from inline data */
>  		dev_write_dump(((unsigned char *)node_blk) + INLINE_DATA_OFFSET,
> @@ -345,6 +400,8 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		else
>  			ASSERT(0);
>  	}
> +
> +	dump_xattr(sbi, node_blk);
>  }
>  
>  static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
