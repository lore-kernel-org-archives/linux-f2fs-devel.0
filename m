From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH 1/2] f2fs-tools: improve loggings
Date: Mon, 19 Mar 2018 11:02:44 +0800
Message-ID: <22eb7733-d790-cefc-eb29-7de85a648848@huawei.com>
References: <20180317150447.124186-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1exl4g-0007fn-VN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:03:02 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1exl4Z-002HgS-KJ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:03:02 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id ACC805778421E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Mar 2018 11:02:46 +0800 (CST)
In-Reply-To: <20180317150447.124186-1-qkrwngud825@gmail.com>
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
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi, Ju Hyung and list,

On 2018/3/17 23:04, Park Ju Hyung wrote:
>   - Print errors and warnings to stderr
>   - Print errors and warnings regardless of debugging level
>   - Make info/error/warning logs consistent
>   - Print POSIX errors when possible
>   - Use more consistent terms and grammar
> 
Shall we handle the last '\n' in different print functions the same way?
ASSERT_MSG() and ASSERT() have '\n' by default, while others don't.
And what is the purpose of TRACE_ERR_MSG() and PERR_MSG()?

thanks,
Sheng

> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>   fsck/defrag.c            |   4 +-
>   fsck/dir.c               |  20 +++----
>   fsck/dump.c              |  12 ++--
>   fsck/fsck.c              |  14 ++---
>   fsck/main.c              |  73 ++++++++++++------------
>   fsck/mount.c             |  62 ++++++++++-----------
>   fsck/quotaio_tree.c      |   2 +-
>   fsck/resize.c            |   8 +--
>   fsck/segment.c           |   4 +-
>   fsck/sload.c             |  29 +++++-----
>   include/f2fs_fs.h        |  34 ++++++++++--
>   lib/libf2fs.c            |  51 +++++++++--------
>   lib/libf2fs_io.c         |  10 ++--
>   lib/libf2fs_zoned.c      |  21 ++++---
>   mkfs/f2fs_format.c       | 140 +++++++++++++++++++++++------------------------
>   mkfs/f2fs_format_main.c  |  54 +++++++++---------
>   mkfs/f2fs_format_utils.c |  14 ++---
>   17 files changed, 291 insertions(+), 261 deletions(-)
> 
> diff --git a/fsck/defrag.c b/fsck/defrag.c
> index bea0293..6ceb1f5 100644
> --- a/fsck/defrag.c
> +++ b/fsck/defrag.c
> @@ -78,12 +78,12 @@ int f2fs_defragment(struct f2fs_sb_info *sbi, u64 from, u64 len, u64 to, int lef
>   			continue;
>   
>   		if (find_next_free_block(sbi, &target, left, se->type)) {
> -			MSG(0, "Not enough space to migrate blocks");
> +			ERR_MSG("Not enough space to migrate blocks");
>   			return -1;
>   		}
>   
>   		if (migrate_block(sbi, idx, target)) {
> -			ASSERT_MSG("Found inconsistency: please run FSCK");
> +			ASSERT_MSG("Found inconsistency, please run FSCK");
>   			return -1;
>   		}
>   	}
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 567a4e9..2e45838 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -235,7 +235,7 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
>   		return -EINVAL;
>   
>   	if (!pino) {
> -		ERR_MSG("Wrong parent ino:%d \n", pino);
> +		TRACE_ERR_MSG("Wrong parent ino: %d\n", pino);
>   		return -EINVAL;
>   	}
>   
> @@ -246,7 +246,7 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
>   start:
>   	if (current_depth == MAX_DIR_HASH_DEPTH) {
>   		free(dentry_blk);
> -		ERR_MSG("\tError: MAX_DIR_HASH\n");
> +		TRACE_ERR_MSG("MAX_DIR_HASH\n");
>   		return -ENOSPC;
>   	}
>   
> @@ -524,7 +524,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>   		ret = dev_write_block(dentry_blk, dn.data_blkaddr);
>   		ASSERT(ret >= 0);
>   
> -		MSG(1, "%s: copy inline entry to block\n", __func__);
> +		MSG(1, "%s: copying inline entry to block\n", __func__);
>   
>   		free(dentry_blk);
>   		return ret;
> @@ -561,9 +561,9 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>   				le32_to_cpu(de->ino),
>   				de->file_type, p_blkaddr, 0);
>   		if (ret)
> -			MSG(0, "Convert file \"%s\" ERR=%d\n", filename, ret);
> +			MSG(0, "Failed to convert file \"%s\", ERR = %d\n", filename, ret);
>   		else
> -			MSG(1, "%s: add inline entry to block\n", __func__);
> +			MSG(1, "%s: adding inline entry to block\n", __func__);
>   
>   		bit_pos += GET_DENTRY_SLOTS(namelen);
>   	}
> @@ -582,7 +582,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   	/* Find if there is a */
>   	get_node_info(sbi, de->pino, &ni);
>   	if (ni.blk_addr == NULL_ADDR) {
> -		MSG(0, "No parent directory pino=%x\n", de->pino);
> +		MSG(0, "No parent directory pino = %x\n", de->pino);
>   		return -1;
>   	}
>   
> @@ -595,13 +595,13 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   	/* Must convert inline dentry before the following opertions */
>   	ret = convert_inline_dentry(sbi, parent, ni.blk_addr);
>   	if (ret) {
> -		MSG(0, "Convert inline dentry for pino=%x failed.\n", de->pino);
> +		MSG(0, "Conversion of inline dentry for pino = %x failed\n", de->pino);
>   		return -1;
>   	}
>   
>   	ret = f2fs_find_entry(sbi, parent, de);
>   	if (ret) {
> -		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
> +		MSG(0, "Skipping existing \"%s\" pino = %x ERR = %d\n",
>   					de->name, de->pino, ret);
>   		if (de->file_type == F2FS_FT_REG_FILE)
>   			de->ino = 0;
> @@ -621,7 +621,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   				map_de_type(le16_to_cpu(child->i.i_mode)),
>   				ni.blk_addr, 1);
>   	if (ret) {
> -		MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
> +		MSG(0, "Skipping existing \"%s\" pino = %x ERR = %d\n",
>   					de->name, de->pino, ret);
>   		goto free_child_dir;
>   	}
> @@ -637,7 +637,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   	ASSERT(ret >= 0);
>   
>   	update_free_segments(sbi);
> -	MSG(1, "Info: Create %s -> %s\n"
> +	MSG(1, "Info: Creating %s -> %s\n"
>   		"  -- ino=%x, type=%x, mode=%x, uid=%x, "
>   		"gid=%x, cap=%"PRIx64", size=%lu, pino=%x\n",
>   		de->full_path, de->path,
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 9236a43..9b9a4b7 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -350,12 +350,12 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk)
>   				       XATTR_TRUSTED_PREFIX, name);
>   			break;
>   		default:
> -			MSG(0, "Unknown xattr index 0x%x\n", ent->e_name_index);
> +			WARN_MSG("Unknown xattr index 0x%x\n", ent->e_name_index);
>   			free(name);
>   			continue;
>   		}
>   		if (ret >= F2FS_NAME_LEN) {
> -			MSG(0, "XATTR index 0x%x name too long\n", ent->e_name_index);
> +			WARN_MSG("xattr index 0x%x: name is too long\n", ent->e_name_index);
>   			free(name);
>   			continue;
>   		}
> @@ -370,8 +370,8 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk)
>   				XATTR_CREATE);
>   #endif
>   		if (ret)
> -			MSG(0, "XATTR index 0x%x set xattr failed error %d\n",
> -			    ent->e_name_index, errno);
> +			PERR_MSG("xattr index 0x%x: fsetxattr() failed",
> +			    ent->e_name_index);
>   
>   		free(name);
>   	}
> @@ -382,7 +382,7 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk)
>   static void dump_xattr(struct f2fs_sb_info *UNUSED(sbi),
>   				struct f2fs_node *UNUSED(node_blk))
>   {
> -	MSG(0, "XATTR does not support\n");
> +	ERR_MSG("xattr is not supported\n");
>   }
>   #endif
>   
> @@ -393,7 +393,7 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>   	u64 ofs = 0;
>   
>   	if((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
> -		DBG(3, "ino[0x%x] has inline data!\n", nid);
> +		DBG(3, "ino[0x%x] has inline data\n", nid);
>   		/* recover from inline data */
>   		dev_write_dump(((unsigned char *)node_blk) + INLINE_DATA_OFFSET,
>   						0, MAX_INLINE_DATA(node_blk));
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index bc91839..b7baa47 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -739,12 +739,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>   				need_fix = 1;
>   			}
>   		}
> -		DBG(3, "ino[0x%x] has inline data!\n", nid);
> +		DBG(3, "ino[0x%x] has inline data\n", nid);
>   		goto check;
>   	}
>   
>   	if ((node_blk->i.i_inline & F2FS_INLINE_DENTRY)) {
> -		DBG(3, "ino[0x%x] has inline dentry!\n", nid);
> +		DBG(3, "ino[0x%x] has inline dentry\n", nid);
>   		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
>   			/* should fix this bug all the time */
>   			FIX_MSG("inline_dentry has wrong 0'th block = %x",
> @@ -1812,28 +1812,28 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
>   			continue;
>   
>   		if (!IS_VALID_BLK_ADDR(sbi, blk)) {
> -			MSG(0, "\tError: nat entry[ino %u block_addr 0x%x]"
> +			ERR_MSG("nat entry[ino %u block_addr 0x%x]"
>   				" is in valid\n",
>   				ino, blk);
>   			return -EINVAL;
>   		}
>   
>   		if (!f2fs_test_sit_bitmap(sbi, blk)) {
> -			MSG(0, "\tError: nat entry[ino %u block_addr 0x%x]"
> +			ERR_MSG("nat entry[ino %u block_addr 0x%x]"
>   				" not find it in sit_area_bitmap\n",
>   				ino, blk);
>   			return -EINVAL;
>   		}
>   
>   		if (!IS_VALID_NID(sbi, ino)) {
> -			MSG(0, "\tError: nat_entry->ino %u exceeds the range"
> +			ERR_MSG("nat_entry->ino %u exceeds the range"
>   				" of nat entries %u\n",
>   				ino, fsck->nr_nat_entries);
>   			return -EINVAL;
>   		}
>   
>   		if (!f2fs_test_bit(ino, fsck->nat_area_bitmap)) {
> -			MSG(0, "\tError: nat_entry->ino %u is not set in"
> +			ERR_MSG("nat_entry->ino %u is not set in"
>   				" nat_area_bitmap\n", ino);
>   			return -EINVAL;
>   		}
> @@ -1889,7 +1889,7 @@ static void fix_hard_links(struct f2fs_sb_info *sbi)
>   		/* Sanity check */
>   		if (sanity_check_nid(sbi, node->nid, node_blk,
>   					F2FS_FT_MAX, TYPE_INODE, &ni))
> -			FIX_MSG("Failed to fix, rerun fsck.f2fs");
> +			FIX_MSG("Failed to fix, please re-run fsck.f2fs");
>   
>   		node_blk->i.i_links = cpu_to_le32(node->actual_links);
>   
> diff --git a/fsck/main.c b/fsck/main.c
> index bbf82c3..581fc8a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -51,7 +51,7 @@ void fsck_usage()
>   	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
>   	MSG(0, "[options]:\n");
>   	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during fsck [default:0]\n");
>   	MSG(0, "  -f check/fix entire partition\n");
>   	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
>   	MSG(0, "  -S sparse_mode\n");
> @@ -66,7 +66,7 @@ void dump_usage()
>   {
>   	MSG(0, "\nUsage: dump.f2fs [options] device\n");
>   	MSG(0, "[options]:\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during dump [default:0]\n");
>   	MSG(0, "  -i inode no (hex)\n");
>   	MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all 0~-1]\n");
>   	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
> @@ -81,7 +81,7 @@ void defrag_usage()
>   {
>   	MSG(0, "\nUsage: defrag.f2fs [options] device\n");
>   	MSG(0, "[options]:\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during defrag [default:0]\n");
>   	MSG(0, "  -s start block address [default: main_blkaddr]\n");
>   	MSG(0, "  -S sparse_mode\n");
>   	MSG(0, "  -l length [default:512 (2MB)]\n");
> @@ -94,7 +94,7 @@ void resize_usage()
>   {
>   	MSG(0, "\nUsage: resize.f2fs [options] device\n");
>   	MSG(0, "[options]:\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during resize [default:0]\n");
>   	MSG(0, "  -t target sectors [default: device size]\n");
>   	exit(1);
>   }
> @@ -110,7 +110,7 @@ void sload_usage()
>   	MSG(0, "  -S sparse_mode\n");
>   	MSG(0, "  -t mount point [prefix of target fs path, default:/]\n");
>   	MSG(0, "  -T timestamp\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during sload [default:0]\n");
>   	exit(1);
>   }
>   
> @@ -137,7 +137,7 @@ static void error_out(char *prog)
>   	else if (!strcmp("sload.f2fs", prog))
>   		sload_usage();
>   	else
> -		MSG(0, "\nWrong program.\n");
> +		ERR_MSG("\nWrong program\n");
>   }
>   
>   void f2fs_parse_options(int argc, char *argv[])
> @@ -155,7 +155,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   	}
>   #endif
>   	if (argc < 2) {
> -		MSG(0, "\tError: Device not specified\n");
> +		ERR_MSG("Device not specified\n");
>   		error_out(prog);
>   	}
>   
> @@ -173,11 +173,11 @@ void f2fs_parse_options(int argc, char *argv[])
>   			switch (option) {
>   			case 1:
>   				c.dry_run = 1;
> -				MSG(0, "Info: Dry run\n");
> +				INFO_MSG("Dry run\n");
>   				break;
>   			case 'a':
>   				c.auto_fix = 1;
> -				MSG(0, "Info: Fix the reported corruption.\n");
> +				INFO_MSG("Fix the reported corruption\n");
>   				break;
>   			case 'p':
>   				/* preen mode has different levels:
> @@ -186,7 +186,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   				 */
>   				if (optarg[0] == '-' || !is_digits(optarg) ||
>   							optind == argc) {
> -					MSG(0, "Info: Use default preen mode\n");
> +					INFO_MSG("Use the default preen mode\n");
>   					c.preen_mode = PREEN_MODE_0;
>   					c.auto_fix = 1;
>   					optind--;
> @@ -199,7 +199,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					c.preen_mode = PREEN_MODE_MAX - 1;
>   				if (c.preen_mode == PREEN_MODE_0)
>   					c.auto_fix = 1;
> -				MSG(0, "Info: Fix the reported corruption in "
> +				INFO_MSG("Fix the reported corruption in "
>   					"preen mode %d\n", c.preen_mode);
>   				break;
>   			case 'd':
> @@ -211,16 +211,16 @@ void f2fs_parse_options(int argc, char *argv[])
>   					break;
>   				}
>   				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
> +				INFO_MSG("Debug level = %d\n", c.dbg_lv);
>   				break;
>   			case 'f':
>   			case 'y':
>   				c.fix_on = 1;
> -				MSG(0, "Info: Force to fix corruption\n");
> +				INFO_MSG("Force to fix corruption\n");
>   				break;
>   			case 'q':
>   				c.preserve_limits = atoi(optarg);
> -				MSG(0, "Info: Preserve quota limits = %d\n",
> +				INFO_MSG("Preserve quota limits = %d\n",
>   					c.preserve_limits);
>   				break;
>   			case 'S':
> @@ -231,7 +231,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   				break;
>   			case ':':
>   				if (optopt == 'p') {
> -					MSG(0, "Info: Use default preen mode\n");
> +					INFO_MSG("Use the default preen mode\n");
>   					c.preen_mode = PREEN_MODE_0;
>   					c.auto_fix = 1;
>   				} else {
> @@ -273,7 +273,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					break;
>   				}
>   				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n",
> +				INFO_MSG("Debug level = %d\n",
>   							c.dbg_lv);
>   				break;
>   			case 'i':
> @@ -334,7 +334,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					break;
>   				}
>   				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n",
> +				INFO_MSG("Debug level = %d\n",
>   							c.dbg_lv);
>   				break;
>   			case 's':
> @@ -389,7 +389,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					break;
>   				}
>   				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n",
> +				INFO_MSG("Debug level = %d\n",
>   							c.dbg_lv);
>   				break;
>   			case 't':
> @@ -429,7 +429,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					break;
>   				}
>   				c.dbg_lv = atoi(optarg);
> -				MSG(0, "Info: Debug level = %d\n",
> +				INFO_MSG("Debug level = %d\n",
>   						c.dbg_lv);
>   				break;
>   			case 'f':
> @@ -443,7 +443,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   				token = strtok(optarg, ",");
>   				while (token) {
>   					if (c.nr_opt == max_nr_opt) {
> -						MSG(0, "\tError: Expected at most %d selinux opts\n",
> +						ERR_MSG("Expected at most %d selinux opts\n",
>   										max_nr_opt);
>   						error_out(prog);
>   					}
> @@ -455,7 +455,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   					token = strtok(NULL, ",");
>   				}
>   #else
> -				MSG(0, "Info: Not support selinux opts\n");
> +				ERR_MSG("SELinux not supported\n");
>   #endif
>   				break;
>   			case 'S':
> @@ -477,7 +477,7 @@ void f2fs_parse_options(int argc, char *argv[])
>   	}
>   
>   	if (optind >= argc) {
> -		MSG(0, "\tError: Device not specified\n");
> +		ERR_MSG("Device not specified\n");
>   		error_out(prog);
>   	}
>   
> @@ -492,16 +492,16 @@ void f2fs_parse_options(int argc, char *argv[])
>   	/* print out error */
>   	switch (err) {
>   	case EWRONG_OPT:
> -		MSG(0, "\tError: Wrong option -%c %s\n", option, optarg);
> +		ERR_MSG("Wrong option -%c %s\n", option, optarg);
>   		break;
>   	case ENEED_ARG:
> -		MSG(0, "\tError: Need argument for -%c\n", option);
> +		ERR_MSG("Need argument for -%c\n", option);
>   		break;
>   	case EUNKNOWN_OPT:
> -		MSG(0, "\tError: Unknown option %c\n", option);
> +		ERR_MSG("Unknown option %c\n", option);
>   		break;
>   	case EUNKNOWN_ARG:
> -		MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
> +		ERR_MSG("Unknown argument %s\n", argv[optind]);
>   		break;
>   	}
>   	error_out(prog);
> @@ -523,7 +523,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
>   		case PREEN_MODE_1:
>   			if (fsck_chk_meta(sbi)) {
>   				MSG(0, "[FSCK] F2FS metadata   [Fail]");
> -				MSG(0, "\tError: meta does not match, "
> +				ERR_MSG("meta does not match, "
>   					"force check all\n");
>   			} else {
>   				MSG(0, "[FSCK] F2FS metadata   [Ok..]");
> @@ -626,12 +626,12 @@ static int do_defrag(struct f2fs_sb_info *sbi)
>   		goto out_range;
>   
>   	if (c.defrag_start > c.defrag_target)
> -		MSG(0, "Info: Move 0x%"PRIx64" <- [0x%"PRIx64"-0x%"PRIx64"]\n",
> +		INFO_MSG("Move 0x%"PRIx64" <- [0x%"PRIx64"-0x%"PRIx64"]\n",
>   				c.defrag_target,
>   				c.defrag_start,
>   				c.defrag_start + c.defrag_len - 1);
>   	else
> -		MSG(0, "Info: Move [0x%"PRIx64"-0x%"PRIx64"] -> 0x%"PRIx64"\n",
> +		INFO_MSG("Move [0x%"PRIx64"-0x%"PRIx64"] -> 0x%"PRIx64"\n",
>   				c.defrag_start,
>   				c.defrag_start + c.defrag_len - 1,
>   				c.defrag_target);
> @@ -662,7 +662,7 @@ static int do_resize(struct f2fs_sb_info *sbi)
>   	/* may different sector size */
>   	if ((c.target_sectors * c.sector_size >>
>   			get_sb(log_blocksize)) <= get_sb(block_count)) {
> -		ASSERT_MSG("Nothing to resize, now only support resize to expand\n");
> +		ASSERT_MSG("Nothing to resize, shrink is not supported\n");
>   		return -1;
>   	}
>   	return f2fs_resize(sbi);
> @@ -671,7 +671,7 @@ static int do_resize(struct f2fs_sb_info *sbi)
>   static int do_sload(struct f2fs_sb_info *sbi)
>   {
>   	if (!c.from_dir) {
> -		MSG(0, "Info: No source directory, but it's okay.\n");
> +		INFO_MSG("No source directory, continuing...\n");
>   		return 0;
>   	}
>   	if (!c.mount_point)
> @@ -693,12 +693,13 @@ int main(int argc, char **argv)
>   		if (errno == EBUSY)
>   			return -1;
>   		if (!c.ro || c.func == DEFRAG) {
> -			MSG(0, "\tError: Not available on mounted device!\n");
> +			ERR_MSG("Cannot proceed on a mounted device\n");
>   			return -1;
>   		}
>   
>   		/* allow ro-mounted partition */
> -		MSG(0, "Info: Check FS only due to RO\n");
> +		WARN_MSG("Proceeding on a read-only mounted device\n");
> +		WARN_MSG("Rebooting immediately after is highly recommended\n");
>   		c.fix_on = 0;
>   		c.auto_fix = 0;
>   	}
> @@ -715,7 +716,7 @@ fsck_again:
>   	ret = f2fs_do_mount(sbi);
>   	if (ret != 0) {
>   		if (ret == 1) {
> -			MSG(0, "Info: No error was reported\n");
> +			INFO_MSG("No errors were reported\n");
>   			ret = 0;
>   		}
>   		goto out_err;
> @@ -756,7 +757,7 @@ fsck_again:
>   		goto fsck_again;
>   #endif
>   	default:
> -		ERR_MSG("Wrong program name\n");
> +		TRACE_ERR_MSG("Wrong program name\n");
>   		ASSERT(0);
>   	}
>   
> @@ -784,7 +785,7 @@ retry:
>   	if (ret < 0)
>   		return ret;
>   
> -	printf("\nDone.\n");
> +	printf("\nDone\n");
>   	return 0;
>   
>   out_err:
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 545f862..906461f 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -64,20 +64,20 @@ void print_acl(char *value, int size)
>   	int i, count;
>   
>   	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION)) {
> -		MSG(0, "Invalid ACL version [0x%x : 0x%x]\n",
> +		ERR_MSG("Invalid ACL version [0x%x : 0x%x]\n",
>   				le32_to_cpu(hdr->a_version), F2FS_ACL_VERSION);
>   		return;
>   	}
>   
>   	count = f2fs_acl_count(size);
>   	if (count <= 0) {
> -		MSG(0, "Invalid ACL value size %d\n", size);
> +		ERR_MSG("Invalid ACL value size %d\n", size);
>   		return;
>   	}
>   
>   	for (i = 0; i < count; i++) {
>   		if ((char *)entry > end) {
> -			MSG(0, "Invalid ACL entries count %d\n", count);
> +			ERR_MSG("Invalid ACL entries count %d\n", count);
>   			return;
>   		}
>   
> @@ -279,7 +279,7 @@ void print_node_info(struct f2fs_sb_info *sbi,
>   		int i;
>   		u32 *dump_blk = (u32 *)node_block;
>   		DBG(verbose,
> -			"Node ID [0x%x:%u] is direct node or indirect node.\n",
> +			"Node ID [0x%x:%u] is direct node or indirect node\n",
>   								nid, nid);
>   		for (i = 0; i <= 10; i++)
>   			MSG(verbose, "[%d]\t\t\t[0x%8x : %d]\n",
> @@ -404,7 +404,7 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
>   
>   void print_cp_state(u32 flag)
>   {
> -	MSG(0, "Info: checkpoint state = %x : ", flag);
> +	INFO_MSG("checkpoint state = %x : ", flag);
>   	if (flag & CP_NOCRC_RECOVERY_FLAG)
>   		MSG(0, "%s", " allow_nocrc");
>   	if (flag & CP_TRIMMED_FLAG)
> @@ -435,7 +435,7 @@ void print_sb_state(struct f2fs_super_block *sb)
>   	__le32 f = sb->feature;
>   	int i;
>   
> -	MSG(0, "Info: superblock features = %x : ", f);
> +	INFO_MSG("superblock features = %x : ", f);
>   	if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
>   		MSG(0, "%s", " encrypt");
>   	}
> @@ -464,7 +464,7 @@ void print_sb_state(struct f2fs_super_block *sb)
>   		MSG(0, "%s", " lost_found");
>   	}
>   	MSG(0, "\n");
> -	MSG(0, "Info: superblock encrypt level = %d, salt = ",
> +	INFO_MSG("superblock encrypt level = %d, salt = ",
>   					sb->encryption_level);
>   	for (i = 0; i < 16; i++)
>   		MSG(0, "%02x", sb->encrypt_pw_salt[i]);
> @@ -493,14 +493,14 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>   				(segment_count << log_blocks_per_seg);
>   
>   	if (segment0_blkaddr != cp_blkaddr) {
> -		MSG(0, "\tMismatch segment0(%u) cp_blkaddr(%u)\n",
> +		ERR_MSG("Mismatch segment0(%u) cp_blkaddr(%u)\n",
>   				segment0_blkaddr, cp_blkaddr);
>   		return -1;
>   	}
>   
>   	if (cp_blkaddr + (segment_count_ckpt << log_blocks_per_seg) !=
>   							sit_blkaddr) {
> -		MSG(0, "\tWrong CP boundary, start(%u) end(%u) blocks(%u)\n",
> +		ERR_MSG("Wrong CP boundary, start(%u) end(%u) blocks(%u)\n",
>   			cp_blkaddr, sit_blkaddr,
>   			segment_count_ckpt << log_blocks_per_seg);
>   		return -1;
> @@ -508,7 +508,7 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>   
>   	if (sit_blkaddr + (segment_count_sit << log_blocks_per_seg) !=
>   							nat_blkaddr) {
> -		MSG(0, "\tWrong SIT boundary, start(%u) end(%u) blocks(%u)\n",
> +		ERR_MSG("Wrong SIT boundary, start(%u) end(%u) blocks(%u)\n",
>   			sit_blkaddr, nat_blkaddr,
>   			segment_count_sit << log_blocks_per_seg);
>   		return -1;
> @@ -516,7 +516,7 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>   
>   	if (nat_blkaddr + (segment_count_nat << log_blocks_per_seg) !=
>   							ssa_blkaddr) {
> -		MSG(0, "\tWrong NAT boundary, start(%u) end(%u) blocks(%u)\n",
> +		ERR_MSG("Wrong NAT boundary, start(%u) end(%u) blocks(%u)\n",
>   			nat_blkaddr, ssa_blkaddr,
>   			segment_count_nat << log_blocks_per_seg);
>   		return -1;
> @@ -524,14 +524,14 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>   
>   	if (ssa_blkaddr + (segment_count_ssa << log_blocks_per_seg) !=
>   							main_blkaddr) {
> -		MSG(0, "\tWrong SSA boundary, start(%u) end(%u) blocks(%u)\n",
> +		ERR_MSG("Wrong SSA boundary, start(%u) end(%u) blocks(%u)\n",
>   			ssa_blkaddr, main_blkaddr,
>   			segment_count_ssa << log_blocks_per_seg);
>   		return -1;
>   	}
>   
>   	if (main_end_blkaddr > seg_end_blkaddr) {
> -		MSG(0, "\tWrong MAIN_AREA, start(%u) end(%u) block(%u)\n",
> +		ERR_MSG("Wrong MAIN_AREA, start(%u) end(%u) block(%u)\n",
>   			main_blkaddr,
>   			segment0_blkaddr +
>   				(segment_count << log_blocks_per_seg),
> @@ -544,7 +544,7 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>   				segment0_blkaddr) >> log_blocks_per_seg);
>   
>   		err = dev_write(sb, offset, sizeof(struct f2fs_super_block));
> -		MSG(0, "Info: Fix alignment: %s, start(%u) end(%u) block(%u)\n",
> +		INFO_MSG("Fix alignment: %s, start(%u) end(%u) block(%u)\n",
>   			err ? "failed": "done",
>   			main_blkaddr,
>   			segment0_blkaddr +
> @@ -589,7 +589,7 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>   	/* Check zoned block device feature */
>   	if (c.devices[0].zoned_model == F2FS_ZONED_HM &&
>   			!(sb->feature & cpu_to_le32(F2FS_FEATURE_BLKZONED))) {
> -		MSG(0, "\tMissing zoned block device feature\n");
> +		ERR_MSG("Missing zoned block device feature\n");
>   		return -1;
>   	}
>   
> @@ -634,8 +634,8 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>   		memcpy(c.init_version, sbi->raw_super->init_version, VERSION_LEN);
>   		get_kernel_version(c.init_version);
>   
> -		MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
> -		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
> +		INFO_MSG("MKFS version\n  \"%s\"\n", c.init_version);
> +		INFO_MSG("FSCK version\n  from \"%s\"\n    to \"%s\"\n",
>   					c.sb_version, c.version);
>   		if (memcmp(c.sb_version, c.version, VERSION_LEN)) {
>   			int ret;
> @@ -655,7 +655,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>   
>   	free(sbi->raw_super);
>   	sbi->raw_super = NULL;
> -	MSG(0, "\tCan't find a valid F2FS superblock at 0x%x\n", block);
> +	ERR_MSG("Unable to find a valid F2FS superblock at 0x%x\n", block);
>   
>   	return -EINVAL;
>   }
> @@ -706,14 +706,14 @@ int init_sb_info(struct f2fs_sb_info *sbi)
>   			c.devices[i].end_blkaddr += get_sb(segment0_blkaddr);
>   
>   		c.ndevs = i + 1;
> -		MSG(0, "Info: Device[%d] : %s blkaddr = %"PRIx64"--%"PRIx64"\n",
> +		INFO_MSG("Device[%d] : %s blkaddr = %"PRIx64"--%"PRIx64"\n",
>   				i, c.devices[i].path,
>   				c.devices[i].start_blkaddr,
>   				c.devices[i].end_blkaddr);
>   	}
>   
>   	total_sectors = get_sb(block_count) << sbi->log_sectors_per_block;
> -	MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
> +	INFO_MSG("Total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
>   				total_sectors, total_sectors >>
>   						(20 - get_sb(log_sectorsize)));
>   	return 0;
> @@ -826,7 +826,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>   	} else
>   		goto fail_no_cp;
>   
> -	MSG(0, "Info: CKPT version = %llx\n", version);
> +	INFO_MSG("CKPT version = %llx\n", version);
>   
>   	memcpy(sbi->ckpt, cur_page, blk_size);
>   
> @@ -1024,9 +1024,9 @@ void write_nat_bits(struct f2fs_sb_info *sbi,
>   
>   	for (i = 0; i < nat_bits_blocks; i++) {
>   		if (dev_write_block(nat_bits + i * F2FS_BLKSIZE, blkaddr + i))
> -			ASSERT_MSG("\tError: write NAT bits to disk!!!\n");
> +			ASSERT_MSG("\tError: write NAT bits to disk\n");
>   	}
> -	MSG(0, "Info: Write valid nat_bits in checkpoint\n");
> +	INFO_MSG("Wrote valid nat_bits in checkpoint\n");
>   
>   	free(nat_bits);
>   }
> @@ -1757,7 +1757,7 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
>   		se->valid_blocks = valid_blocks;
>   		type = se->type;
>   		if (type >= NO_CHECK_TYPE) {
> -			ASSERT_MSG("Invalide type and valid blocks=%x,%x",
> +			ASSERT_MSG("Invalid type and valid blocks=%x,%x",
>   					segno, valid_blocks);
>   			type = 0;
>   		}
> @@ -2292,10 +2292,10 @@ static int check_sector_size(struct f2fs_super_block *sb)
>   	set_sb(log_sectors_per_block, log_sectors_per_block);
>   
>   	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
> -	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
> +	DBG(1, "\tWriting superblock, at offset 0x%08x\n", 0);
>   	for (index = 0; index < 2; index++) {
>   		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
> -			MSG(1, "\tError: Failed while writing supe_blk "
> +			ERR_MSG("Failed while writing superblock "
>   				"on disk!!! index : %d\n", index);
>   			free(zero_buff);
>   			return -1;
> @@ -2331,12 +2331,12 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>   
>   	ret = get_valid_checkpoint(sbi);
>   	if (ret) {
> -		ERR_MSG("Can't find valid checkpoint\n");
> +		TRACE_ERR_MSG("Unable to find a valid checkpoint\n");
>   		return -1;
>   	}
>   
>   	if (sanity_check_ckpt(sbi)) {
> -		ERR_MSG("Checkpoint is polluted\n");
> +		TRACE_ERR_MSG("Checkpoint is polluted\n");
>   		return -1;
>   	}
>   	cp = F2FS_CKPT(sbi);
> @@ -2371,12 +2371,12 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>   	sbi->alloc_valid_block_count = 0;
>   
>   	if (build_segment_manager(sbi)) {
> -		ERR_MSG("build_segment_manager failed\n");
> +		TRACE_ERR_MSG("build_segment_manager failed\n");
>   		return -1;
>   	}
>   
>   	if (build_node_manager(sbi)) {
> -		ERR_MSG("build_node_manager failed\n");
> +		TRACE_ERR_MSG("build_node_manager failed\n");
>   		return -1;
>   	}
>   
> @@ -2401,7 +2401,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>   		if (*kaddr != get_cp_crc(cp))
>   			write_nat_bits(sbi, sb, cp, sbi->cur_cp);
>   		else
> -			MSG(0, "Info: Found valid nat_bits in checkpoint\n");
> +			INFO_MSG("Found valid nat_bits in checkpoint\n");
>   		free(kaddr);
>   	}
>   	return 0;
> diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
> index 5aef228..e4ce5da 100644
> --- a/fsck/quotaio_tree.c
> +++ b/fsck/quotaio_tree.c
> @@ -587,7 +587,7 @@ static int check_reference(struct quota_handle *h, unsigned int blk)
>   {
>   	if (blk >= h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks) {
>   		log_err("Illegal reference (%u >= %u) in %s quota file. "
> -			"Quota file is probably corrupted.\n"
> +			"Quota file is probably corrupted\n"
>   			"Please run fsck (8) to fix it.",
>   			blk,
>   			h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks,
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 7643511..5107dfb 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -149,8 +149,8 @@ static int get_new_sb(struct f2fs_super_block *sb)
>   	if ((get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
>   		get_sb(segment_count_main) * blks_per_seg >
>   						get_sb(block_count)) {
> -		MSG(0, "\tError: Device size is not sufficient for F2FS volume, "
> -			"more segment needed =%u",
> +		ERR_MSG("Device size is not sufficient for F2FS volume, "
> +			"more segment needed = %u",
>   			c.new_reserved_segments -
>   			(get_sb(segment_count_main) - 2));
>   		return -1;
> @@ -604,7 +604,7 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
>   	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
>   		err = shrink_nats(sbi, new_sb);
>   		if (err) {
> -			MSG(0, "\tError: Failed to shrink NATs\n");
> +			ERR_MSG("Failed to shrink NATs\n");
>   			return err;
>   		}
>   	}
> @@ -624,7 +624,7 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
>   						new_main_blkaddr, 0);
>   		if (!err)
>   			offset_seg = offset >> get_sb(log_blocks_per_seg);
> -		MSG(0, "Try to do defragement: %s\n", err ? "Skip": "Done");
> +		MSG(0, "Try to do defragement: %s\n", err ? "skip" : "done");
>   	}
>   	/* move whole data region */
>   	if (err)
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 4f8bdb4..9955a21 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -35,7 +35,7 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
>   	blkaddr = SM_I(sbi)->main_blkaddr;
>   
>   	if (find_next_free_block(sbi, &blkaddr, 0, type)) {
> -		ERR_MSG("Not enough space to allocate blocks");
> +		TRACE_ERR_MSG("Not enough space to allocate blocks");
>   		ASSERT(0);
>   	}
>   
> @@ -283,7 +283,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
>   
>   	fd = open(de->full_path, O_RDONLY);
>   	if (fd < 0) {
> -		MSG(0, "Skip: Fail to open %s\n", de->full_path);
> +		PERR_MSG("Fail to open %s\n", de->full_path);
>   		return -1;
>   	}
>   
> diff --git a/fsck/sload.c b/fsck/sload.c
> index 2842f2c..3481346 100644
> --- a/fsck/sload.c
> +++ b/fsck/sload.c
> @@ -67,14 +67,14 @@ static int set_selinux_xattr(struct f2fs_sb_info *sbi, const char *path,
>   		return 0;
>   
>   	if (asprintf(&mnt_path, "%s%s", c.mount_point, path) <= 0) {
> -		ERR_MSG("cannot allocate security path for %s%s\n",
> +		TRACE_ERR_MSG("Cannot allocate security path for %s%s\n",
>   						c.mount_point, path);
>   		return -ENOMEM;
>   	}
>   
>   	/* set root inode selinux context */
>   	if (selabel_lookup(sehnd, &secontext, mnt_path, mode) < 0) {
> -		ERR_MSG("cannot lookup security context for %s\n", mnt_path);
> +		TRACE_ERR_MSG("Cannot lookup security context for %s\n", mnt_path);
>   		free(mnt_path);
>   		return -EINVAL;
>   	}
> @@ -99,7 +99,7 @@ static int set_perms_and_caps(struct dentry *de)
>   	char *mnt_path = NULL;
>   
>   	if (asprintf(&mnt_path, "%s%s", c.mount_point, de->path) <= 0) {
> -		ERR_MSG("cannot allocate mount path for %s%s\n",
> +		TRACE_ERR_MSG("Cannot allocate mount path for %s%s\n",
>   				c.mount_point, de->path);
>   		return -ENOMEM;
>   	}
> @@ -128,7 +128,8 @@ static void set_inode_metadata(struct dentry *de)
>   
>   	ret = lstat(de->full_path, &stat);
>   	if (ret < 0) {
> -		ERR_MSG("lstat failure\n");
> +		PERR_MSG("lstat() failed\n");
> +		TRACE_ERR_MSG();
>   		ASSERT(0);
>   	}
>   
> @@ -151,7 +152,7 @@ static void set_inode_metadata(struct dentry *de)
>   		ret = readlink(de->full_path, de->link, F2FS_BLKSIZE - 1);
>   		ASSERT(ret >= 0);
>   	} else {
> -		ERR_MSG("unknown file type on %s", de->path);
> +		TRACE_ERR_MSG("Unknown file type on %s", de->path);
>   		ASSERT(0);
>   	}
>   
> @@ -177,7 +178,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
>   
>   	entries = scandir(full_path, &namelist, filter_dot, (void *)alphasort);
>   	if (entries < 0) {
> -		ERR_MSG("No entries in %s\n", full_path);
> +		TRACE_ERR_MSG("No entries in %s\n", full_path);
>   		return -ENOENT;
>   	}
>   
> @@ -188,7 +189,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
>   	for (i = 0; i < entries; i++) {
>   		dentries[i].name = (unsigned char *)strdup(namelist[i]->d_name);
>   		if (dentries[i].name == NULL) {
> -			ERR_MSG("Skip: ENOMEM\n");
> +			TRACE_ERR_MSG("Skip: ENOMEM\n");
>   			continue;
>   		}
>   		dentries[i].len = strlen((char *)dentries[i].name);
> @@ -234,7 +235,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
>   			 * f2fs_make_symlink(sbi, dir_ino, &dentries[i]);
>   			 */
>   		} else {
> -			MSG(1, "Error unknown file type\n");
> +			ERR_MSG("unknown file type\n");
>   		}
>   
>   		ret = set_selinux_xattr(sbi, dentries[i].path,
> @@ -259,14 +260,14 @@ static int configure_files(void)
>   #if !defined(__ANDROID__)
>   	sehnd = selabel_open(SELABEL_CTX_FILE, c.seopt_file, c.nr_opt);
>   	if (!sehnd) {
> -		ERR_MSG("Failed to open file contexts \"%s\"",
> +		TRACE_ERR_MSG("Failed to open file contexts \"%s\"",
>   					c.seopt_file[0].value);
>   			return -EINVAL;
>   	}
>   #else
>   	sehnd = selinux_android_file_context_handle();
>   	if (!sehnd) {
> -		ERR_MSG("Failed to get android file_contexts\n", c.mount_point);
> +		TRACE_ERR_MSG("Failed to get android file_contexts\n", c.mount_point);
>   		return -EINVAL;
>   	}
>   #endif
> @@ -278,7 +279,7 @@ skip:
>   		int ret = load_canned_fs_config(c.fs_config_file);
>   
>   		if (ret < 0) {
> -			ERR_MSG("Failed to load fs_config \"%s\"",
> +			TRACE_ERR_MSG("Failed to load fs_config \"%s\"",
>   						c.fs_config_file);
>   			return ret;
>   		}
> @@ -296,7 +297,7 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
>   
>   	ret = configure_files();
>   	if (ret) {
> -		ERR_MSG("Failed to configure files\n");
> +		TRACE_ERR_MSG("Failed to configure files\n");
>   		return ret;
>   	}
>   
> @@ -306,14 +307,14 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
>   	ret = build_directory(sbi, c.from_dir, "/",
>   					c.target_out_dir, F2FS_ROOT_INO(sbi));
>   	if (ret) {
> -		ERR_MSG("Failed to build due to %d\n", ret);
> +		TRACE_ERR_MSG("Failed to build due to %d\n", ret);
>   		return ret;
>   	}
>   
>   	ret = set_selinux_xattr(sbi, c.mount_point,
>   					F2FS_ROOT_INO(sbi), S_IFDIR);
>   	if (ret) {
> -		ERR_MSG("Failed to set selinux for root: %d\n", ret);
> +		TRACE_ERR_MSG("Failed to set SELinux for root: %d\n", ret);
>   		return ret;
>   	}
>   
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index c460050..1df7265 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -44,6 +44,9 @@
>   #include <selinux/label.h>
>   #endif
>   
> +#include <string.h>
> +#include <errno.h>
> +
>   #ifdef UNUSED
>   #elif defined(__GNUC__)
>   # define UNUSED(x) UNUSED_ ## x __attribute__((unused))
> @@ -179,23 +182,46 @@ static inline uint64_t bswap_64(uint64_t val)
>   
>   #define ASSERT_MSG(fmt, ...)						\
>   	do {								\
> -		printf("[ASSERT] (%s:%4d) ", __func__, __LINE__);	\
> -		printf(" --> "fmt"\n", ##__VA_ARGS__);			\
> +		fprintf(stderr, "[ASSERT] (%s:%4d) ",			\
> +				__func__, __LINE__);			\
> +		fprintf(stderr, " --> "fmt"\n", ##__VA_ARGS__);		\
>   		c.bug_on = 1;						\
>   	} while (0)
>   
>   #define ASSERT(exp)							\
>   	do {								\
>   		if (!(exp)) {						\
> -			printf("[ASSERT] (%s:%4d) " #exp"\n",		\
> +			fprintf(stderr, "[ASSERT] (%s:%4d) " #exp"\n",	\
>   					__func__, __LINE__);		\
>   			exit(-1);					\
>   		}							\
>   	} while (0)
>   
> +#define TRACE_ERR_MSG(fmt, ...)						\
> +	do {								\
> +		fprintf(stderr, "[%s:%d] " fmt,				\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +	} while (0)
> +
> +#define PERR_MSG(fmt, ...)						\
> +	do {								\
> +		fprintf(stderr, "\tError: " fmt, ##__VA_ARGS__);	\
> +		fprintf(stderr, ": %s\n", strerror(errno));		\
> +	} while (0)
> +
>   #define ERR_MSG(fmt, ...)						\
>   	do {								\
> -		printf("[%s:%d] " fmt, __func__, __LINE__, ##__VA_ARGS__); \
> +		fprintf(stderr, "\tError: " fmt, ##__VA_ARGS__);	\
> +	} while (0)
> +
> +#define WARN_MSG(fmt, ...)						\
> +	do {								\
> +		fprintf(stderr, "\tWarning: " fmt, ##__VA_ARGS__);	\
> +	} while (0)
> +
> +#define INFO_MSG(fmt, ...)						\
> +	do {								\
> +		printf("Info: " fmt, ##__VA_ARGS__);			\
>   	} while (0)
>   
>   #define MSG(n, fmt, ...)						\
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 0c684d5..4fc6d06 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -656,7 +656,7 @@ int f2fs_dev_is_umounted(char *path)
>   #ifdef __linux__
>   	ret = is_mounted("/proc/mounts", path);
>   	if (ret) {
> -		MSG(0, "Info: Mounted device!\n");
> +		ERR_MSG("Cannot proceed on a mounted device\n");
>   		return -1;
>   	}
>   #endif
> @@ -666,7 +666,7 @@ int f2fs_dev_is_umounted(char *path)
>   #endif
>   	ret = is_mounted(MOUNTED, path);
>   	if (ret) {
> -		MSG(0, "Info: Mounted device!\n");
> +		ERR_MSG("Cannot proceed on a mounted device\n");
>   		return -1;
>   	}
>   #endif
> @@ -679,7 +679,7 @@ int f2fs_dev_is_umounted(char *path)
>   #ifdef __linux__
>   		ret = is_mounted("/proc/mounts", "/dev/root");
>   		if (ret) {
> -			MSG(0, "Info: Mounted device!\n");
> +			ERR_MSG("Cannot proceed on a mounted device\n");
>   			return -1;
>   		}
>   #endif
> @@ -695,7 +695,7 @@ int f2fs_dev_is_umounted(char *path)
>   		if (fd >= 0) {
>   			close(fd);
>   		} else if (errno == EBUSY) {
> -			MSG(0, "\tError: In use by the system!\n");
> +			ERR_MSG("Cannot proceed on a device currently in use\n");
>   			return -1;
>   		}
>   	}
> @@ -767,7 +767,7 @@ int get_device_info(int i)
>   		fd = open((char *)dev->path, O_RDWR);
>   	}
>   	if (fd < 0) {
> -		MSG(0, "\tError: Failed to open the device!\n");
> +		PERR_MSG("Failed to open the device");
>   		return -1;
>   	}
>   
> @@ -781,13 +781,13 @@ int get_device_info(int i)
>   	if (c.kd == -1) {
>   		c.kd = open("/proc/version", O_RDONLY);
>   		if (c.kd < 0) {
> -			MSG(0, "\tInfo: No support kernel version!\n");
> +			WARN_MSG("Cannot resolve kernel version");
>   			c.kd = -2;
>   		}
>   	}
>   
>   	if (fstat(fd, &stat_buf) < 0 ) {
> -		MSG(0, "\tError: Failed to get the device stat!\n");
> +		ERR_MSG("Failed to get the device stat\n");
>   		return -1;
>   	}
>   
> @@ -798,18 +798,18 @@ int get_device_info(int i)
>   	} else if (S_ISBLK(stat_buf.st_mode)) {
>   #ifdef BLKSSZGET
>   		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
> -			MSG(0, "\tError: Using the default sector size\n");
> +			ERR_MSG("Using the default sector size\n");
>   		else if (dev->sector_size < sector_size)
>   			dev->sector_size = sector_size;
>   #endif
>   #ifdef BLKGETSIZE64
>   		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
> -			MSG(0, "\tError: Cannot get the device size\n");
> +			ERR_MSG("Cannot get the device size\n");
>   			return -1;
>   		}
>   #else
>   		if (ioctl(fd, BLKGETSIZE, &total_sectors) < 0) {
> -			MSG(0, "\tError: Cannot get the device size\n");
> +			ERR_MSG("Cannot get the device size\n");
>   			return -1;
>   		}
>   		dev->total_sectors = total_sectors;
> @@ -841,15 +841,14 @@ int get_device_info(int i)
>   		if (!ioctl(fd, SG_IO, &io_hdr)) {
>   			int i = 16;
>   
> -			MSG(0, "Info: [%s] Disk Model: ",
> -					dev->path);
> +			INFO_MSG("[%s] Disk Model: ", dev->path);
>   			while (reply_buffer[i] != '`' && i < 80)
>   				printf("%c", reply_buffer[i++]);
>   			printf("\n");
>   		}
>   #endif
>   	} else {
> -		MSG(0, "\tError: Volume type is not supported!!!\n");
> +		ERR_MSG("Volume type is not supported\n");
>   		return -1;
>   	}
>   
> @@ -857,7 +856,7 @@ int get_device_info(int i)
>   		c.sector_size = dev->sector_size;
>   		c.sectors_per_blk = F2FS_BLKSIZE / c.sector_size;
>   	} else if (c.sector_size != c.devices[i].sector_size) {
> -		MSG(0, "\tError: Different sector sizes!!!\n");
> +		ERR_MSG("Different sector sizes\n");
>   		return -1;
>   	}
>   
> @@ -870,15 +869,15 @@ int get_device_info(int i)
>   			c.zoned_model = F2FS_ZONED_HM;
>   
>   		if (f2fs_get_zone_blocks(i)) {
> -			MSG(0, "\tError: Failed to get number of blocks per zone\n");
> +			ERR_MSG("Failed to get number of blocks per zone\n");
>   			return -1;
>   		}
>   
>   		if (f2fs_check_zones(i)) {
> -			MSG(0, "\tError: Failed to check zone configuration\n");
> +			ERR_MSG("Failed to check zone configuration\n");
>   			return -1;
>   		}
> -		MSG(0, "Info: Host-%s zoned block device:\n",
> +		INFO_MSG("Host-%s zoned block device:\n",
>   				(dev->zoned_model == F2FS_ZONED_HA) ?
>   					"aware" : "managed");
>   		MSG(0, "      %u zones, %u randomly writeable zones\n",
> @@ -961,7 +960,7 @@ int get_device_info(int i)
>   	/* Block device target is not supported on Windows. */
>   	if (!c.sparse_mode) {
>   		if (win_get_device_size(dev->path, &device_size)) {
> -			MSG(0, "\tError: Failed to get device size!\n");
> +			ERR_MSG("Failed to get device size\n");
>   			return -1;
>   		}
>   	} else {
> @@ -973,7 +972,7 @@ int get_device_info(int i)
>   		fd = open((char *)dev->path, O_RDWR | O_BINARY);
>   	}
>   	if (fd < 0) {
> -		MSG(0, "\tError: Failed to open the device!\n");
> +		PERR_MSG("Failed to open the device");
>   		return -1;
>   	}
>   	dev->fd = fd;
> @@ -996,14 +995,14 @@ int f2fs_get_device_info(void)
>   			return -1;
>   
>   	if (c.wanted_total_sectors < c.total_sectors) {
> -		MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
> +		INFO_MSG("Total device sectors = %"PRIu64" (in %u bytes)\n",
>   				c.total_sectors, c.sector_size);
>   		c.total_sectors = c.wanted_total_sectors;
>   		c.devices[0].total_sectors = c.total_sectors;
>   	}
>   	if (c.total_sectors * c.sector_size >
>   		(u_int64_t)F2FS_MAX_SEGMENT * 2 * 1024 * 1024) {
> -		MSG(0, "\tError: F2FS can support 16TB at most!!!\n");
> +		ERR_MSG("F2FS can support 16TB at most\n");
>   		return -1;
>   	}
>   
> @@ -1011,7 +1010,7 @@ int f2fs_get_device_info(void)
>   		if (c.devices[i].zoned_model != F2FS_ZONED_NONE) {
>   			if (c.zone_blocks &&
>   				c.zone_blocks != c.devices[i].zone_blocks) {
> -				MSG(0, "\tError: not support different zone sizes!!!\n");
> +				ERR_MSG("Different zone sizes are not supported\n");
>   				return -1;
>   			}
>   			c.zone_blocks = c.devices[i].zone_blocks;
> @@ -1031,10 +1030,10 @@ int f2fs_get_device_info(void)
>   
>   	c.segs_per_zone = c.segs_per_sec * c.secs_per_zone;
>   
> -	MSG(0, "Info: Segments per section = %d\n", c.segs_per_sec);
> -	MSG(0, "Info: Sections per zone = %d\n", c.secs_per_zone);
> -	MSG(0, "Info: sector size = %u\n", c.sector_size);
> -	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
> +	INFO_MSG("Segments per section = %d\n", c.segs_per_sec);
> +	INFO_MSG("Sections per zone = %d\n", c.secs_per_zone);
> +	INFO_MSG("Sector size = %u\n", c.sector_size);
> +	INFO_MSG("Total sectors = %"PRIu64" (%"PRIu64" MB)\n",
>   				c.total_sectors, (c.total_sectors *
>   					(c.sector_size >> 9)) >> 11);
>   	return 0;
> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index 4781517..da36cca 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -268,7 +268,7 @@ int f2fs_fsync_device(void)
>   
>   	for (i = 0; i < c.ndevs; i++) {
>   		if (fsync(c.devices[i].fd) < 0) {
> -			MSG(0, "\tError: Could not conduct fsync!!!\n");
> +			PERR_MSG("Cannot fsync() device");
>   			return -1;
>   		}
>   	}
> @@ -292,7 +292,7 @@ int f2fs_init_sparse_file(void)
>   	}
>   
>   	if (sparse_file_block_size(f2fs_sparse_file) != F2FS_BLKSIZE) {
> -		MSG(0, "\tError: Corrupted sparse file\n");
> +		ERR_MSG("Corrupted sparse file\n");
>   		return -1;
>   	}
>   	blocks_count = c.device_size / F2FS_BLKSIZE;
> @@ -301,7 +301,7 @@ int f2fs_init_sparse_file(void)
>   	return sparse_file_foreach_chunk(f2fs_sparse_file, true, false,
>   				sparse_import_segment, NULL);
>   #else
> -	MSG(0, "\tError: Sparse mode is only supported for android\n");
> +	ERR_MSG("Sparse mode is only supported for android\n");
>   	return -1;
>   #endif
>   }
> @@ -360,13 +360,13 @@ int f2fs_finalize_device(void)
>   #ifndef ANDROID_WINDOWS_HOST
>   		ret = fsync(c.devices[i].fd);
>   		if (ret < 0) {
> -			MSG(0, "\tError: Could not conduct fsync!!!\n");
> +			PERR_MSG("Cannot fsync() device");
>   			break;
>   		}
>   #endif
>   		ret = close(c.devices[i].fd);
>   		if (ret < 0) {
> -			MSG(0, "\tError: Failed to close device file!!!\n");
> +			ERR_MSG("Failed to close the device\n");
>   			break;
>   		}
>   	}
> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> index 6e32f32..1cc56d3 100644
> --- a/lib/libf2fs_zoned.c
> +++ b/lib/libf2fs_zoned.c
> @@ -117,7 +117,7 @@ int f2fs_check_zones(int j)
>   
>   	rep = malloc(F2FS_REPORT_ZONES_BUFSZ);
>   	if (!rep) {
> -		ERR_MSG("No memory for report zones\n");
> +		ERR_MSG("Cannot allocate memory for report zones\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -135,8 +135,9 @@ int f2fs_check_zones(int j)
>   
>   		ret = ioctl(dev->fd, BLKREPORTZONE, rep);
>   		if (ret != 0) {
> +			PERR_MSG("ioctl() with BLKREPORTZONE failed");
>   			ret = -errno;
> -			ERR_MSG("ioctl BLKREPORTZONE failed\n");
> +			TRACE_ERR_MSG();
>   			goto out;
>   		}
>   
> @@ -204,7 +205,7 @@ int f2fs_check_zones(int j)
>   
>   	if (dev->zoned_model == F2FS_ZONED_HM &&
>   			!dev->nr_rnd_zones) {
> -		ERR_MSG("No conventional zone for super block\n");
> +		ERR_MSG("No conventional zone for superblock\n");
>   		ret = -1;
>   	}
>   out:
> @@ -225,7 +226,7 @@ int f2fs_reset_zones(int j)
>   
>   	rep = malloc(F2FS_REPORT_ZONES_BUFSZ);
>   	if (!rep) {
> -		ERR_MSG("No memory for report zones\n");
> +		ERR_MSG("Cannot allocate memory for report zones\n");
>   		return -1;
>   	}
>   
> @@ -241,8 +242,9 @@ int f2fs_reset_zones(int j)
>   
>   		ret = ioctl(dev->fd, BLKREPORTZONE, rep);
>   		if (ret != 0) {
> +			PERR_MSG("ioctl() with BLKREPORTZONES failed");
>   			ret = -errno;
> -			ERR_MSG("ioctl BLKREPORTZONES failed\n");
> +			TRACE_ERR_MSG();
>   			goto out;
>   		}
>   
> @@ -258,8 +260,9 @@ int f2fs_reset_zones(int j)
>   				range.nr_sectors = blk_zone_length(blkz);
>   				ret = ioctl(dev->fd, BLKRESETZONE, &range);
>   				if (ret != 0) {
> +					PERR_MSG("ioctl() with BLKRESETZONE failed");
>   					ret = -errno;
> -					ERR_MSG("ioctl BLKRESETZONE failed\n");
> +					TRACE_ERR_MSG();
>   					goto out;
>   				}
>   			}
> @@ -270,7 +273,7 @@ int f2fs_reset_zones(int j)
>   out:
>   	free(rep);
>   	if (!ret)
> -		MSG(0, "Info: Discarded %"PRIu64" MB\n", (sector << 9) >> 20);
> +		INFO_MSG("Discarded %"PRIu64" MB\n", (sector << 9) >> 20);
>   	return ret;
>   }
>   
> @@ -298,13 +301,13 @@ int f2fs_get_zone_blocks(int i)
>   
>   int f2fs_check_zones(int i)
>   {
> -	ERR_MSG("%d: Zoned block devices are not supported\n", i);
> +	TRACE_ERR_MSG("%d: Zoned block devices are not supported\n", i);
>   	return -1;
>   }
>   
>   int f2fs_reset_zones(int i)
>   {
> -	ERR_MSG("%d: Zoned block devices are not supported\n", i);
> +	TRACE_ERR_MSG("%d: Zoned block devices are not supported\n", i);
>   	return -1;
>   }
>   
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index aa372ca..94bcea1 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -186,7 +186,7 @@ static void cure_extension_list(void)
>   		while (ue != NULL) {
>   			name_len = strlen(ue);
>   			if (name_len >= 8) {
> -				MSG(0, "\tWarn: Extension name (%s) is too long\n", ue);
> +				WARN_MSG("Extension name (%s) is too long\n", ue);
>   				goto next;
>   			}
>   			if (!is_extension_exist(ue))
> @@ -293,12 +293,12 @@ static int f2fs_prepare_super_block(void)
>   	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>   	sb->cp_blkaddr = sb->segment0_blkaddr;
>   
> -	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
> +	INFO_MSG("Zone aligned segment0 blkaddr: %u\n",
>   					get_sb(segment0_blkaddr));
>   
>   	if (c.zoned_mode && (get_sb(segment0_blkaddr) + c.start_sector /
>   					c.sectors_per_blk) % c.zone_blocks) {
> -		MSG(1, "\tError: Unaligned segment0 block address %u\n",
> +		ERR_MSG("Unaligned segment0 block address %u\n",
>   				get_sb(segment0_blkaddr));
>   		return -1;
>   	}
> @@ -452,7 +452,7 @@ static int f2fs_prepare_super_block(void)
>   
>   		if (c.devices[0].zoned_model == F2FS_ZONED_HM &&
>   				c.devices[0].nr_rnd_zones < main_blkzone) {
> -			MSG(0, "\tError: Device does not have enough random "
> +			ERR_MSG("Device does not have enough random "
>   					"write zones for F2FS volume (%lu needed)\n",
>   					main_blkzone);
>   			return -1;
> @@ -474,7 +474,7 @@ static int f2fs_prepare_super_block(void)
>   		(c.devices[0].total_sectors *
>   			c.sector_size < zone_align_start_offset) ||
>   		(get_sb(segment_count_main) - 2) < c.reserved_segments) {
> -		MSG(0, "\tError: Device size is not sufficient for F2FS volume\n");
> +		ERR_MSG("Device size is not sufficient for F2FS volume\n");
>   		return -1;
>   	}
>   
> @@ -505,7 +505,7 @@ static int f2fs_prepare_super_block(void)
>   		if (!((1 << qtype) & quotatype_bits))
>   			continue;
>   		sb->qf_ino[qtype] = cpu_to_le32(c.next_free_nid++);
> -		MSG(0, "Info: add quota type = %u => %u\n",
> +		INFO_MSG("Adding quota type = %u => %u\n",
>   					qtype, c.next_free_nid - 1);
>   	}
>   
> @@ -513,7 +513,7 @@ static int f2fs_prepare_super_block(void)
>   		c.lpf_ino = c.next_free_nid++;
>   
>   	if (total_zones <= 6) {
> -		MSG(1, "\tError: %d zones: Need more zones "
> +		ERR_MSG("%d zones: Need more zones "
>   			"by shrinking zone size\n", total_zones);
>   		return -1;
>   	}
> @@ -548,7 +548,7 @@ static int f2fs_prepare_super_block(void)
>   	if (c.kd >= 0) {
>   		dev_read_version(c.version, 0, VERSION_LEN);
>   		get_kernel_version(c.version);
> -		MSG(0, "Info: format version with\n  \"%s\"\n", c.version);
> +		INFO_MSG("Formatting with version\n  \"%s\"\n", c.version);
>   	} else {
>   		memset(c.version, 0, VERSION_LEN);
>   	}
> @@ -573,7 +573,7 @@ static int f2fs_init_sit_area(void)
>   
>   	zero_buf = calloc(sizeof(u_int8_t), seg_size);
>   	if(zero_buf == NULL) {
> -		MSG(1, "\tError: Calloc Failed for sit_zero_buf!!!\n");
> +		ERR_MSG("Failed to allocate memory for sit_zero_buf\n");
>   		return -1;
>   	}
>   
> @@ -583,8 +583,8 @@ static int f2fs_init_sit_area(void)
>   	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
>   	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
>   		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
> -			MSG(1, "\tError: While zeroing out the sit area "
> -					"on disk!!!\n");
> +			ERR_MSG("While zeroing out the sit area "
> +					"on disk\n");
>   			free(zero_buf);
>   			return -1;
>   		}
> @@ -607,7 +607,7 @@ static int f2fs_init_nat_area(void)
>   
>   	nat_buf = calloc(sizeof(u_int8_t), seg_size);
>   	if (nat_buf == NULL) {
> -		MSG(1, "\tError: Calloc Failed for nat_zero_blk!!!\n");
> +		ERR_MSG("Failed to allocate memory for nat_zero_blk\n");
>   		return -1;
>   	}
>   
> @@ -617,8 +617,8 @@ static int f2fs_init_nat_area(void)
>   	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
>   	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
>   		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
> -			MSG(1, "\tError: While zeroing out the nat area "
> -					"on disk!!!\n");
> +			ERR_MSG("While zeroing out the nat area "
> +					"on disk\n");
>   			free(nat_buf);
>   			return -1;
>   		}
> @@ -648,19 +648,19 @@ static int f2fs_write_check_point_pack(void)
>   
>   	cp = calloc(F2FS_BLKSIZE, 1);
>   	if (cp == NULL) {
> -		MSG(1, "\tError: Calloc Failed for f2fs_checkpoint!!!\n");
> +		ERR_MSG("Failed to allocate memory for f2fs_checkpoint\n");
>   		return ret;
>   	}
>   
>   	sum = calloc(F2FS_BLKSIZE, 1);
>   	if (sum == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay_node!!!\n");
> +		ERR_MSG("Failed to allocate memory for summay_node\n");
>   		goto free_cp;
>   	}
>   
>   	sum_compact = calloc(F2FS_BLKSIZE, 1);
>   	if (sum_compact == NULL) {
> -		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
> +		ERR_MSG("Failed to allocate memory for summay buffer\n");
>   		goto free_sum;
>   	}
>   	sum_compact_p = sum_compact;
> @@ -670,13 +670,13 @@ static int f2fs_write_check_point_pack(void)
>   						F2FS_BLKSIZE - 1);
>   	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
>   	if (nat_bits == NULL) {
> -		MSG(1, "\tError: Calloc Failed for nat bits buffer!!!\n");
> +		ERR_MSG("Failed to allocate memory for nat bits buffer\n");
>   		goto free_sum_compact;
>   	}
>   
>   	cp_payload = calloc(F2FS_BLKSIZE, 1);
>   	if (cp_payload == NULL) {
> -		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
> +		ERR_MSG("Failed to allocate memory for cp_payload\n");
>   		goto free_nat_bits;
>   	}
>   
> @@ -705,8 +705,8 @@ static int f2fs_write_check_point_pack(void)
>   	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
>   			get_cp(rsvd_segment_count));
>   
> -	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.overprovision);
> -	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
> +	INFO_MSG("Overprovision ratio = %.3lf%%\n", c.overprovision);
> +	INFO_MSG("Overprovision segments = %u (GC reserved = %u)\n",
>   					get_cp(overprov_segment_count),
>   					c.reserved_segments);
>   
> @@ -747,7 +747,7 @@ static int f2fs_write_check_point_pack(void)
>   	blk_size_bytes = 1 << get_sb(log_blocksize);
>   
>   	if (blk_size_bytes != F2FS_BLKSIZE) {
> -		MSG(1, "\tError: Wrong block size %d / %d!!!\n",
> +		ERR_MSG("Wrong block size %d / %d\n",
>   					blk_size_bytes, F2FS_BLKSIZE);
>   		goto free_cp_payload;
>   	}
> @@ -757,15 +757,15 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n",
>   						cp_seg_blk);
>   	if (dev_write_block(cp, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the cp to disk!!!\n");
> +		ERR_MSG("While writing cp to disk\n");
>   		goto free_cp_payload;
>   	}
>   
>   	for (i = 0; i < get_sb(cp_payload); i++) {
>   		cp_seg_blk++;
>   		if (dev_fill_block(cp_payload, cp_seg_blk)) {
> -			MSG(1, "\tError: While zeroing out the sit bitmap area "
> -					"on disk!!!\n");
> +			ERR_MSG("While zeroing out the sit bitmap area "
> +					"on disk\n");
>   			goto free_cp_payload;
>   		}
>   	}
> @@ -894,7 +894,7 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting Segment summary for HOT/WARM/COLD_DATA, at offset 0x%08"PRIx64"\n",
>   			cp_seg_blk);
>   	if (dev_write_block(sum_compact, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
> +		ERR_MSG("While writing sum_blk to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -921,7 +921,7 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting Segment summary for HOT_NODE, at offset 0x%08"PRIx64"\n",
>   			cp_seg_blk);
>   	if (dev_write_block(sum, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
> +		ERR_MSG("While writing sum_blk to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -933,7 +933,7 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting Segment summary for WARM_NODE, at offset 0x%08"PRIx64"\n",
>   			cp_seg_blk);
>   	if (dev_write_block(sum, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
> +		ERR_MSG("While writing sum_blk to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -944,7 +944,7 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting Segment summary for COLD_NODE, at offset 0x%08"PRIx64"\n",
>   			cp_seg_blk);
>   	if (dev_write_block(sum, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
> +		ERR_MSG("While writing sum_blk to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -952,7 +952,7 @@ static int f2fs_write_check_point_pack(void)
>   	cp_seg_blk++;
>   	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk);
>   	if (dev_write_block(cp, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the cp to disk!!!\n");
> +		ERR_MSG("While writing cp to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -975,7 +975,7 @@ static int f2fs_write_check_point_pack(void)
>   		for (i = 0; i < nat_bits_blocks; i++) {
>   			if (dev_write_block(nat_bits + i *
>   						F2FS_BLKSIZE, cp_seg_blk + i)) {
> -				MSG(1, "\tError: write NAT bits to disk!!!\n");
> +				ERR_MSG("While writing NAT bits to disk\n");
>   				goto free_cp_payload;
>   			}
>   		}
> @@ -993,15 +993,15 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
>   				cp_seg_blk);
>   	if (dev_write_block(cp, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the cp to disk!!!\n");
> +		ERR_MSG("While writing cp to disk\n");
>   		goto free_cp_payload;
>   	}
>   
>   	for (i = 0; i < get_sb(cp_payload); i++) {
>   		cp_seg_blk++;
>   		if (dev_fill_block(cp_payload, cp_seg_blk)) {
> -			MSG(1, "\tError: While zeroing out the sit bitmap area "
> -					"on disk!!!\n");
> +			ERR_MSG("While zeroing out the sit bitmap area "
> +					"on disk\n");
>   			goto free_cp_payload;
>   		}
>   	}
> @@ -1012,7 +1012,7 @@ static int f2fs_write_check_point_pack(void)
>   	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
>   				cp_seg_blk);
>   	if (dev_write_block(cp, cp_seg_blk)) {
> -		MSG(1, "\tError: While writing the cp to disk!!!\n");
> +		ERR_MSG("While writing cp to disk\n");
>   		goto free_cp_payload;
>   	}
>   
> @@ -1039,11 +1039,11 @@ static int f2fs_write_super_block(void)
>   	zero_buff = calloc(F2FS_BLKSIZE, 1);
>   
>   	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
> -	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
> +	DBG(1, "\tWriting superblock, at offset 0x%08x\n", 0);
>   	for (index = 0; index < 2; index++) {
>   		if (dev_write_block(zero_buff, index)) {
> -			MSG(1, "\tError: While while writing supe_blk "
> -					"on disk!!! index : %d\n", index);
> +			ERR_MSG("While writing superblock "
> +					"on disk index : %d\n", index);
>   			free(zero_buff);
>   			return -1;
>   		}
> @@ -1082,7 +1082,7 @@ static int f2fs_discard_obsolete_dnode(void)
>   			break;
>   
>   		if (dev_read_block(raw_node, offset)) {
> -			MSG(1, "\tError: While traversing direct node!!!\n");
> +			ERR_MSG("While traversing direct node\n");
>   			free(raw_node);
>   			return -1;
>   		}
> @@ -1092,7 +1092,7 @@ static int f2fs_discard_obsolete_dnode(void)
>   
>   		DBG(1, "\tDiscard dnode, at offset 0x%08"PRIx64"\n", offset);
>   		if (dev_write_block(raw_node, offset)) {
> -			MSG(1, "\tError: While discarding direct node!!!\n");
> +			ERR_MSG("While discarding direct node\n");
>   			free(raw_node);
>   			return -1;
>   		}
> @@ -1115,7 +1115,7 @@ static int f2fs_write_root_inode(void)
>   
>   	raw_node = calloc(F2FS_BLKSIZE, 1);
>   	if (raw_node == NULL) {
> -		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
> +		ERR_MSG("Failed to allocate memory for raw_node\n");
>   		return -1;
>   	}
>   
> @@ -1186,7 +1186,7 @@ static int f2fs_write_root_inode(void)
>   			c.cur_seg[CURSEG_HOT_NODE],
>   			c.blks_per_seg, main_area_node_seg_blk_offset);
>   	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
> -		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
> +		ERR_MSG("While writing raw_node to disk\n");
>   		free(raw_node);
>   		return -1;
>   	}
> @@ -1205,7 +1205,7 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr,
>   	struct v2r1_disk_dqblk dqblk;
>   
>   	if (filebuf == NULL) {
> -		MSG(1, "\tError: Calloc Failed for filebuf!!!\n");
> +		ERR_MSG("Failed to allocate memory for filebuf\n");
>   		return -1;
>   	}
>   
> @@ -1255,7 +1255,7 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr,
>   	/* Write two blocks */
>   	if (dev_write_block(filebuf, blkaddr) ||
>   	    dev_write_block(filebuf + F2FS_BLKSIZE, blkaddr + 1)) {
> -		MSG(1, "\tError: While writing the quota_blk to disk!!!\n");
> +		ERR_MSG("While writing quota_blk to disk\n");
>   		free(filebuf);
>   		return -1;
>   	}
> @@ -1276,7 +1276,7 @@ static int f2fs_write_qf_inode(int qtype)
>   
>   	raw_node = calloc(F2FS_BLKSIZE, 1);
>   	if (raw_node == NULL) {
> -		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
> +		ERR_MSG("Failed to allocate memory for raw_node\n");
>   		return -1;
>   	}
>   
> @@ -1358,7 +1358,7 @@ static int f2fs_write_qf_inode(int qtype)
>   			c.cur_seg[CURSEG_HOT_NODE],
>   			c.blks_per_seg, main_area_node_seg_blk_offset);
>   	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
> -		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
> +		ERR_MSG("While writing raw_node to disk\n");
>   		free(raw_node);
>   		return -1;
>   	}
> @@ -1377,7 +1377,7 @@ static int f2fs_update_nat_root(void)
>   
>   	nat_blk = calloc(F2FS_BLKSIZE, 1);
>   	if(nat_blk == NULL) {
> -		MSG(1, "\tError: Calloc Failed for nat_blk!!!\n");
> +		ERR_MSG("Failed to allocate memory for nat_blk\n");
>   		return -1;
>   	}
>   
> @@ -1412,7 +1412,7 @@ static int f2fs_update_nat_root(void)
>   	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n",
>   					nat_seg_blk_offset);
>   	if (dev_write_block(nat_blk, nat_seg_blk_offset)) {
> -		MSG(1, "\tError: While writing the nat_blk set0 to disk!\n");
> +		ERR_MSG("While writing nat_blk set0 to disk\n");
>   		free(nat_blk);
>   		return -1;
>   	}
> @@ -1428,7 +1428,7 @@ static block_t f2fs_add_default_dentry_lpf(void)
>   
>   	dent_blk = calloc(F2FS_BLKSIZE, 1);
>   	if (dent_blk == NULL) {
> -		MSG(1, "\tError: Calloc Failed for dent_blk!!!\n");
> +		ERR_MSG("Failed to allocate memory for dent_blk\n");
>   		return 0;
>   	}
>   
> @@ -1454,7 +1454,7 @@ static block_t f2fs_add_default_dentry_lpf(void)
>   	DBG(1, "\tWriting default dentry lost+found, at offset 0x%08"PRIx64"\n",
>   			data_blk_offset);
>   	if (dev_write_block(dent_blk, data_blk_offset)) {
> -		MSG(1, "\tError While writing the dentry_blk to disk!!!\n");
> +		ERR_MSG("While writing dentry_blk to disk\n");
>   		free(dent_blk);
>   		return 0;
>   	}
> @@ -1475,7 +1475,7 @@ static int f2fs_write_lpf_inode(void)
>   
>   	raw_node = calloc(F2FS_BLKSIZE, 1);
>   	if (raw_node == NULL) {
> -		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
> +		ERR_MSG("Failed to allocate memory for raw_node\n");
>   		return -1;
>   	}
>   
> @@ -1527,7 +1527,7 @@ static int f2fs_write_lpf_inode(void)
>   
>   	data_blk_nor = f2fs_add_default_dentry_lpf();
>   	if (data_blk_nor == 0) {
> -		MSG(1, "\tError: Failed to add default dentries for lost+found!!!\n");
> +		ERR_MSG("Failed to add default dentries for lost+found\n");
>   		err = -1;
>   		goto exit;
>   	}
> @@ -1546,7 +1546,7 @@ static int f2fs_write_lpf_inode(void)
>   			c.cur_seg[CURSEG_HOT_NODE],
>   			c.blks_per_seg, main_area_node_seg_blk_offset);
>   	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
> -		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
> +		ERR_MSG("While writing raw_node to disk\n");
>   		err = -1;
>   		goto exit;
>   	}
> @@ -1564,7 +1564,7 @@ static int f2fs_add_default_dentry_root(void)
>   
>   	dent_blk = calloc(F2FS_BLKSIZE, 1);
>   	if(dent_blk == NULL) {
> -		MSG(1, "\tError: Calloc Failed for dent_blk!!!\n");
> +		ERR_MSG("Failed to allocate memory for dent_blk\n");
>   		return -1;
>   	}
>   
> @@ -1608,7 +1608,7 @@ static int f2fs_add_default_dentry_root(void)
>   	DBG(1, "\tWriting default dentry root, at offset 0x%08"PRIx64"\n",
>   				data_blk_offset);
>   	if (dev_write_block(dent_blk, data_blk_offset)) {
> -		MSG(1, "\tError: While writing the dentry_blk to disk!!!\n");
> +		ERR_MSG("While writing dentry_blk to disk\n");
>   		free(dent_blk);
>   		return -1;
>   	}
> @@ -1624,7 +1624,7 @@ static int f2fs_create_root_dir(void)
>   
>   	err = f2fs_write_root_inode();
>   	if (err < 0) {
> -		MSG(1, "\tError: Failed to write root inode!!!\n");
> +		ERR_MSG("Failed to write root inode\n");
>   		goto exit;
>   	}
>   
> @@ -1633,7 +1633,7 @@ static int f2fs_create_root_dir(void)
>   			continue;
>   		err = f2fs_write_qf_inode(qtype);
>   		if (err < 0) {
> -			MSG(1, "\tError: Failed to write quota inode!!!\n");
> +			ERR_MSG("Failed to write quota inode\n");
>   			goto exit;
>   		}
>   	}
> @@ -1641,7 +1641,7 @@ static int f2fs_create_root_dir(void)
>   	if (c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
>   		err = f2fs_write_lpf_inode();
>   		if (err < 0) {
> -			MSG(1, "\tError: Failed to write lost+found inode!!!\n");
> +			ERR_MSG("Failed to write lost+found inode\n");
>   			goto exit;
>   		}
>   	}
> @@ -1649,25 +1649,25 @@ static int f2fs_create_root_dir(void)
>   #ifndef WITH_ANDROID
>   	err = f2fs_discard_obsolete_dnode();
>   	if (err < 0) {
> -		MSG(1, "\tError: Failed to discard obsolete dnode!!!\n");
> +		ERR_MSG("Failed to discard obsolete dnode\n");
>   		goto exit;
>   	}
>   #endif
>   
>   	err = f2fs_update_nat_root();
>   	if (err < 0) {
> -		MSG(1, "\tError: Failed to update NAT for root!!!\n");
> +		ERR_MSG("Failed to update NAT for root\n");
>   		goto exit;
>   	}
>   
>   	err = f2fs_add_default_dentry_root();
>   	if (err < 0) {
> -		MSG(1, "\tError: Failed to add default dentries for root!!!\n");
> +		ERR_MSG("Failed to add default dentries for root\n");
>   		goto exit;
>   	}
>   exit:
>   	if (err)
> -		MSG(1, "\tError: Could not create the root directory!!!\n");
> +		ERR_MSG("Could not create the root directory\n");
>   
>   	return err;
>   }
> @@ -1678,50 +1678,50 @@ int f2fs_format_device(void)
>   
>   	err= f2fs_prepare_super_block();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to prepare a super block!!!\n");
> +		ERR_MSG("Failed to prepare a superblock\n");
>   		goto exit;
>   	}
>   
>   	if (c.trim) {
>   		err = f2fs_trim_devices();
>   		if (err < 0) {
> -			MSG(0, "\tError: Failed to trim whole device!!!\n");
> +			ERR_MSG("Failed to trim the whole device\n");
>   			goto exit;
>   		}
>   	}
>   
>   	err = f2fs_init_sit_area();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to Initialise the SIT AREA!!!\n");
> +		ERR_MSG("Failed to initialise SIT area\n");
>   		goto exit;
>   	}
>   
>   	err = f2fs_init_nat_area();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to Initialise the NAT AREA!!!\n");
> +		ERR_MSG("Failed to initialise NAT area\n");
>   		goto exit;
>   	}
>   
>   	err = f2fs_create_root_dir();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to create the root directory!!!\n");
> +		ERR_MSG("Failed to create the root directory\n");
>   		goto exit;
>   	}
>   
>   	err = f2fs_write_check_point_pack();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to write the check point pack!!!\n");
> +		ERR_MSG("Failed to write checkpoint pack\n");
>   		goto exit;
>   	}
>   
>   	err = f2fs_write_super_block();
>   	if (err < 0) {
> -		MSG(0, "\tError: Failed to write the Super Block!!!\n");
> +		ERR_MSG("Failed to write superblock\n");
>   		goto exit;
>   	}
>   exit:
>   	if (err)
> -		MSG(0, "\tError: Could not format the device!!!\n");
> +		ERR_MSG("Could not format the device\n");
>   
>   	return err;
>   }
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 56ca741..3fffec8 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -43,11 +43,11 @@ static void mkfs_usage()
>   	MSG(0, "[options]:\n");
>   	MSG(0, "  -a heap-based allocation [default:0]\n");
>   	MSG(0, "  -c [device path] up to 7 devices excepts meta device\n");
> -	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -d print debugging logs during mkfs [default:0]\n");
>   	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
>   	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
>   	MSG(0, "     If no list is given, the default list will be printed\n");
> -	MSG(0, "  -f force overwrite the exist filesystem\n");
> +	MSG(0, "  -f force overwriting the existing filesystem\n");
>   	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
>   	MSG(0, "  -l label\n");
>   	MSG(0, "  -m support zoned block device [default:0]\n");
> @@ -68,17 +68,17 @@ static void f2fs_show_info()
>   				F2FS_TOOLS_VERSION,
>   				F2FS_TOOLS_DATE);
>   	if (c.heap == 0)
> -		MSG(0, "Info: Disable heap-based policy\n");
> +		INFO_MSG("Disabling heap-based policy\n");
>   
> -	MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
> +	INFO_MSG("Debug level = %d\n", c.dbg_lv);
>   	if (c.extension_list[0])
> -		MSG(0, "Info: Add new cold file extension list\n");
> +		INFO_MSG("Adding new cold file extension list\n");
>   	if (c.extension_list[1])
> -		MSG(0, "Info: Add new hot file extension list\n");
> +		INFO_MSG("Adding new hot file extension list\n");
>   
>   	if (c.vol_label)
> -		MSG(0, "Info: Label = %s\n", c.vol_label);
> -	MSG(0, "Info: Trim is %s\n", c.trim ? "enabled": "disabled");
> +		INFO_MSG("Label = %s\n", c.vol_label);
> +	INFO_MSG("%s trim\n", c.trim ? "Enabling": "Disabling");
>   }
>   
>   static void parse_feature(const char *features)
> @@ -102,7 +102,7 @@ static void parse_feature(const char *features)
>   	} else if (!strcmp(features, "lost_found")) {
>   		c.feature |= cpu_to_le32(F2FS_FEATURE_LOST_FOUND);
>   	} else {
> -		MSG(0, "Error: Wrong features\n");
> +		ERR_MSG("Wrong features\n");
>   		mkfs_usage();
>   	}
>   }
> @@ -122,12 +122,12 @@ static void f2fs_parse_options(int argc, char *argv[])
>   			break;
>   		case 'c':
>   			if (c.ndevs >= MAX_DEVICES) {
> -				MSG(0, "Error: Too many devices\n");
> +				ERR_MSG("Too many devices\n");
>   				mkfs_usage();
>   			}
>   
>   			if (strlen(optarg) > MAX_PATH_LEN) {
> -				MSG(0, "Error: device path should be less than "
> +				ERR_MSG("device path should be less than "
>   					"%d characters\n", MAX_PATH_LEN);
>   				mkfs_usage();
>   			}
> @@ -151,7 +151,7 @@ static void f2fs_parse_options(int argc, char *argv[])
>   			break;
>   		case 'l':		/*v: volume label */
>   			if (strlen(optarg) > 512) {
> -				MSG(0, "Error: Volume Label should be less than "
> +				ERR_MSG("Volume Label should be less than "
>   						"512 characters\n");
>   				mkfs_usage();
>   			}
> @@ -184,7 +184,7 @@ static void f2fs_parse_options(int argc, char *argv[])
>   			force_overwrite = 1;
>   			break;
>   		default:
> -			MSG(0, "\tError: Unknown option %c\n",option);
> +			ERR_MSG("Unknown option %c\n",option);
>   			mkfs_usage();
>   			break;
>   		}
> @@ -192,29 +192,29 @@ static void f2fs_parse_options(int argc, char *argv[])
>   
>   	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR))) {
>   		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
> -			MSG(0, "\tInfo: project quota feature should always been"
> +			ERR_MSG("project quota feature should always been"
>   				"enabled with extra attr feature\n");
>   			exit(1);
>   		}
>   		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
> -			MSG(0, "\tInfo: inode checksum feature should always been"
> +			ERR_MSG("inode checksum feature should always been"
>   				"enabled with extra attr feature\n");
>   			exit(1);
>   		}
>   		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
> -			MSG(0, "\tInfo: flexible inline xattr feature should always been"
> +			ERR_MSG("flexible inline xattr feature should always been"
>   				"enabled with extra attr feature\n");
>   			exit(1);
>   		}
>   		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
> -			MSG(0, "\tInfo: inode crtime feature should always been"
> +			ERR_MSG("inode crtime feature should always been"
>   				"enabled with extra attr feature\n");
>   			exit(1);
>   		}
>   	}
>   
>   	if (optind >= argc) {
> -		MSG(0, "\tError: Device not specified\n");
> +		ERR_MSG("Device not specified\n");
>   		mkfs_usage();
>   	}
>   
> @@ -223,7 +223,7 @@ static void f2fs_parse_options(int argc, char *argv[])
>   
>   	if ((optind + 1) < argc) {
>   		if (c.ndevs > 1) {
> -			MSG(0, "\tError: Not support custom size on multi-devs.\n");
> +			ERR_MSG("Not support custom size on multi-devs\n");
>   			mkfs_usage();
>   		}
>   		c.wanted_total_sectors = atoll(argv[optind+1]);
> @@ -271,10 +271,10 @@ static int f2fs_dev_is_overwrite(const char *device)
>   	}
>   
>   	if (!blkid_probe_lookup_value(pr, "TYPE", &type, NULL)) {
> -		MSG(0, "\t%s appears to contain an existing filesystem (%s).\n",
> +		MSG(0, "\t%s appears to contain an existing filesystem (%s)\n",
>   			device, type);
>   	} else if (!blkid_probe_lookup_value(pr, "PTTYPE", &type, NULL)) {
> -		MSG(0, "\t%s appears to contain a partition table (%s).\n",
> +		MSG(0, "\t%s appears to contain a partition table (%s)\n",
>   			device, type);
>   	} else {
>   		MSG(0, "\t%s appears to contain something weird according to blkid\n",
> @@ -285,7 +285,7 @@ out:
>   	if (pr)
>   		blkid_free_probe(pr);
>   	if (ret == -1)
> -		MSG(0, "\tprobe of %s failed, cannot detect existing filesystem.\n",
> +		MSG(0, "\tprobe of %s failed, cannot detect existing filesystem\n",
>   			device);
>   	return ret;
>   }
> @@ -320,13 +320,13 @@ int main(int argc, char *argv[])
>   	c.func = MKFS;
>   
>   	if (!force_overwrite && f2fs_check_overwrite()) {
> -		MSG(0, "\tUse the -f option to force overwrite.\n");
> +		MSG(0, "\tUse the -f option to force overwrite\n");
>   		return -1;
>   	}
>   
>   	if (f2fs_devs_are_umounted() < 0) {
>   		if (errno != EBUSY)
> -			MSG(0, "\tError: Not available on mounted device!\n");
> +			ERR_MSG("Cannot proceed on a mounted device\n");
>   		return -1;
>   	}
>   
> @@ -338,12 +338,12 @@ int main(int argc, char *argv[])
>   	 * zoned block devices.
>   	 */
>   	if (c.zoned_model == F2FS_ZONED_HM && !c.zoned_mode) {
> -		MSG(0, "\tError: zoned block device feature is required\n");
> +		ERR_MSG("Zoned block device feature is required\n");
>   		return -1;
>   	}
>   
>   	if (c.zoned_mode && !c.trim) {
> -		MSG(0, "\tError: Trim is required for zoned block devices\n");
> +		ERR_MSG("Trim is required for zoned block devices\n");
>   		return -1;
>   	}
>   
> @@ -358,7 +358,7 @@ int main(int argc, char *argv[])
>   	if (f2fs_finalize_device() < 0)
>   		return -1;
>   
> -	MSG(0, "Info: format successful\n");
> +	INFO_MSG("Format successful\n");
>   
>   	return 0;
>   }
> diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
> index e481a8f..dd00347 100644
> --- a/mkfs/f2fs_format_utils.c
> +++ b/mkfs/f2fs_format_utils.c
> @@ -50,7 +50,7 @@ static int trim_device(int i)
>   	int fd = dev->fd;
>   
>   	if (fstat(fd, &stat_buf) < 0 ) {
> -		MSG(1, "\tError: Failed to get the device stat!!!\n");
> +		PERR_MSG("Failed to get the device stat");
>   		return -1;
>   	}
>   
> @@ -58,12 +58,12 @@ static int trim_device(int i)
>   	range[1] = bytes;
>   
>   #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
> -	MSG(0, "Info: [%s] Discarding device\n", dev->path);
> +	INFO_MSG("[%s] Discarding device\n", dev->path);
>   	if (S_ISREG(stat_buf.st_mode)) {
>   #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
>   		if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>   				range[0], range[1]) < 0) {
> -			MSG(0, "Info: fallocate(PUNCH_HOLE|KEEP_SIZE) is failed\n");
> +			PERR_MSG("fallocate(PUNCH_HOLE|KEEP_SIZE) is failed");
>   		}
>   #endif
>   		return 0;
> @@ -72,17 +72,17 @@ static int trim_device(int i)
>   			return f2fs_reset_zones(i);
>   #ifdef BLKSECDISCARD
>   		if (ioctl(fd, BLKSECDISCARD, &range) < 0) {
> -			MSG(0, "Info: This device doesn't support BLKSECDISCARD\n");
> +			INFO_MSG("This device doesn't support BLKSECDISCARD\n");
>   		} else {
> -			MSG(0, "Info: Secure Discarded %lu MB\n",
> +			INFO_MSG("Secure-discarded %lu MB\n",
>   					(unsigned long)stat_buf.st_size >> 20);
>   			return 0;
>   		}
>   #endif
>   		if (ioctl(fd, BLKDISCARD, &range) < 0) {
> -			MSG(0, "Info: This device doesn't support BLKDISCARD\n");
> +			INFO_MSG("This device doesn't support BLKDISCARD\n");
>   		} else {
> -			MSG(0, "Info: Discarded %llu MB\n", range[1] >> 20);
> +			INFO_MSG("Discarded %llu MB\n", range[1] >> 20);
>   		}
>   	} else
>   		return -1;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
