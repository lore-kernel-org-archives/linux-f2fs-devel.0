From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 1/2] f2fs-tools: improve loggings
Date: Mon, 19 Mar 2018 12:14:37 +0900
Message-ID: <CAD14+f2izJADRz1tUOgrscBg9gE7UDpUgU5fehp+D1M1Zag4Yw@mail.gmail.com>
References: <20180317150447.124186-1-qkrwngud825@gmail.com>
 <22eb7733-d790-cefc-eb29-7de85a648848@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exlG4-0001GX-6g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:14:48 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-ua0-f195.google.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exlG1-005RLn-Cs
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:14:48 +0000
Received: by mail-ua0-f195.google.com with SMTP id d1so10018758ual.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 18 Mar 2018 20:14:45 -0700 (PDT)
In-Reply-To: <22eb7733-d790-cefc-eb29-7de85a648848@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Sheng,

> Shall we handle the last '\n' in different print functions the same way?
Some MSG() calls didn't have '\n' at the end with a very good reason.
For consistencies between MSG, INFO_MSG and ERR_MSG, I left "\n" to the caller.

> And what is the purpose of TRACE_ERR_MSG()
TRACE_ERR_MSG() was previously ERR_MSG().
It prints the function and line number for developers to easily
identify where the log came from.

> and PERR_MSG()?
perror() + ERR_MSG().
It prints out POSIX error's description to tell users why if failed.
"No such file or directory" or "Permission denied" is a good example.

On Mon, Mar 19, 2018 at 12:02 PM, Sheng Yong <shengyong1@huawei.com> wrote:
> Hi, Ju Hyung and list,
>
> On 2018/3/17 23:04, Park Ju Hyung wrote:
>>
>>   - Print errors and warnings to stderr
>>   - Print errors and warnings regardless of debugging level
>>   - Make info/error/warning logs consistent
>>   - Print POSIX errors when possible
>>   - Use more consistent terms and grammar
>>
> Shall we handle the last '\n' in different print functions the same way?
> ASSERT_MSG() and ASSERT() have '\n' by default, while others don't.
> And what is the purpose of TRACE_ERR_MSG() and PERR_MSG()?
>
> thanks,
> Sheng
>
>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
>> ---
>>   fsck/defrag.c            |   4 +-
>>   fsck/dir.c               |  20 +++----
>>   fsck/dump.c              |  12 ++--
>>   fsck/fsck.c              |  14 ++---
>>   fsck/main.c              |  73 ++++++++++++------------
>>   fsck/mount.c             |  62 ++++++++++-----------
>>   fsck/quotaio_tree.c      |   2 +-
>>   fsck/resize.c            |   8 +--
>>   fsck/segment.c           |   4 +-
>>   fsck/sload.c             |  29 +++++-----
>>   include/f2fs_fs.h        |  34 ++++++++++--
>>   lib/libf2fs.c            |  51 +++++++++--------
>>   lib/libf2fs_io.c         |  10 ++--
>>   lib/libf2fs_zoned.c      |  21 ++++---
>>   mkfs/f2fs_format.c       | 140
>> +++++++++++++++++++++++------------------------
>>   mkfs/f2fs_format_main.c  |  54 +++++++++---------
>>   mkfs/f2fs_format_utils.c |  14 ++---
>>   17 files changed, 291 insertions(+), 261 deletions(-)
>>
>> diff --git a/fsck/defrag.c b/fsck/defrag.c
>> index bea0293..6ceb1f5 100644
>> --- a/fsck/defrag.c
>> +++ b/fsck/defrag.c
>> @@ -78,12 +78,12 @@ int f2fs_defragment(struct f2fs_sb_info *sbi, u64
>> from, u64 len, u64 to, int lef
>>                         continue;
>>                 if (find_next_free_block(sbi, &target, left, se->type)) {
>> -                       MSG(0, "Not enough space to migrate blocks");
>> +                       ERR_MSG("Not enough space to migrate blocks");
>>                         return -1;
>>                 }
>>                 if (migrate_block(sbi, idx, target)) {
>> -                       ASSERT_MSG("Found inconsistency: please run
>> FSCK");
>> +                       ASSERT_MSG("Found inconsistency, please run
>> FSCK");
>>                         return -1;
>>                 }
>>         }
>> diff --git a/fsck/dir.c b/fsck/dir.c
>> index 567a4e9..2e45838 100644
>> --- a/fsck/dir.c
>> +++ b/fsck/dir.c
>> @@ -235,7 +235,7 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct
>> f2fs_node *parent,
>>                 return -EINVAL;
>>         if (!pino) {
>> -               ERR_MSG("Wrong parent ino:%d \n", pino);
>> +               TRACE_ERR_MSG("Wrong parent ino: %d\n", pino);
>>                 return -EINVAL;
>>         }
>>   @@ -246,7 +246,7 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct
>> f2fs_node *parent,
>>   start:
>>         if (current_depth == MAX_DIR_HASH_DEPTH) {
>>                 free(dentry_blk);
>> -               ERR_MSG("\tError: MAX_DIR_HASH\n");
>> +               TRACE_ERR_MSG("MAX_DIR_HASH\n");
>>                 return -ENOSPC;
>>         }
>>   @@ -524,7 +524,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi,
>> struct f2fs_node *node,
>>                 ret = dev_write_block(dentry_blk, dn.data_blkaddr);
>>                 ASSERT(ret >= 0);
>>   -             MSG(1, "%s: copy inline entry to block\n", __func__);
>> +               MSG(1, "%s: copying inline entry to block\n", __func__);
>>                 free(dentry_blk);
>>                 return ret;
>> @@ -561,9 +561,9 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi,
>> struct f2fs_node *node,
>>                                 le32_to_cpu(de->ino),
>>                                 de->file_type, p_blkaddr, 0);
>>                 if (ret)
>> -                       MSG(0, "Convert file \"%s\" ERR=%d\n", filename,
>> ret);
>> +                       MSG(0, "Failed to convert file \"%s\", ERR =
>> %d\n", filename, ret);
>>                 else
>> -                       MSG(1, "%s: add inline entry to block\n",
>> __func__);
>> +                       MSG(1, "%s: adding inline entry to block\n",
>> __func__);
>>                 bit_pos += GET_DENTRY_SLOTS(namelen);
>>         }
>> @@ -582,7 +582,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct
>> dentry *de)
>>         /* Find if there is a */
>>         get_node_info(sbi, de->pino, &ni);
>>         if (ni.blk_addr == NULL_ADDR) {
>> -               MSG(0, "No parent directory pino=%x\n", de->pino);
>> +               MSG(0, "No parent directory pino = %x\n", de->pino);
>>                 return -1;
>>         }
>>   @@ -595,13 +595,13 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct
>> dentry *de)
>>         /* Must convert inline dentry before the following opertions */
>>         ret = convert_inline_dentry(sbi, parent, ni.blk_addr);
>>         if (ret) {
>> -               MSG(0, "Convert inline dentry for pino=%x failed.\n",
>> de->pino);
>> +               MSG(0, "Conversion of inline dentry for pino = %x
>> failed\n", de->pino);
>>                 return -1;
>>         }
>>         ret = f2fs_find_entry(sbi, parent, de);
>>         if (ret) {
>> -               MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
>> +               MSG(0, "Skipping existing \"%s\" pino = %x ERR = %d\n",
>>                                         de->name, de->pino, ret);
>>                 if (de->file_type == F2FS_FT_REG_FILE)
>>                         de->ino = 0;
>> @@ -621,7 +621,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct
>> dentry *de)
>>                                 map_de_type(le16_to_cpu(child->i.i_mode)),
>>                                 ni.blk_addr, 1);
>>         if (ret) {
>> -               MSG(0, "Skip the existing \"%s\" pino=%x ERR=%d\n",
>> +               MSG(0, "Skipping existing \"%s\" pino = %x ERR = %d\n",
>>                                         de->name, de->pino, ret);
>>                 goto free_child_dir;
>>         }
>> @@ -637,7 +637,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct
>> dentry *de)
>>         ASSERT(ret >= 0);
>>         update_free_segments(sbi);
>> -       MSG(1, "Info: Create %s -> %s\n"
>> +       MSG(1, "Info: Creating %s -> %s\n"
>>                 "  -- ino=%x, type=%x, mode=%x, uid=%x, "
>>                 "gid=%x, cap=%"PRIx64", size=%lu, pino=%x\n",
>>                 de->full_path, de->path,
>> diff --git a/fsck/dump.c b/fsck/dump.c
>> index 9236a43..9b9a4b7 100644
>> --- a/fsck/dump.c
>> +++ b/fsck/dump.c
>> @@ -350,12 +350,12 @@ static void dump_xattr(struct f2fs_sb_info *sbi,
>> struct f2fs_node *node_blk)
>>                                        XATTR_TRUSTED_PREFIX, name);
>>                         break;
>>                 default:
>> -                       MSG(0, "Unknown xattr index 0x%x\n",
>> ent->e_name_index);
>> +                       WARN_MSG("Unknown xattr index 0x%x\n",
>> ent->e_name_index);
>>                         free(name);
>>                         continue;
>>                 }
>>                 if (ret >= F2FS_NAME_LEN) {
>> -                       MSG(0, "XATTR index 0x%x name too long\n",
>> ent->e_name_index);
>> +                       WARN_MSG("xattr index 0x%x: name is too long\n",
>> ent->e_name_index);
>>                         free(name);
>>                         continue;
>>                 }
>> @@ -370,8 +370,8 @@ static void dump_xattr(struct f2fs_sb_info *sbi,
>> struct f2fs_node *node_blk)
>>                                 XATTR_CREATE);
>>   #endif
>>                 if (ret)
>> -                       MSG(0, "XATTR index 0x%x set xattr failed error
>> %d\n",
>> -                           ent->e_name_index, errno);
>> +                       PERR_MSG("xattr index 0x%x: fsetxattr() failed",
>> +                           ent->e_name_index);
>>                 free(name);
>>         }
>> @@ -382,7 +382,7 @@ static void dump_xattr(struct f2fs_sb_info *sbi,
>> struct f2fs_node *node_blk)
>>   static void dump_xattr(struct f2fs_sb_info *UNUSED(sbi),
>>                                 struct f2fs_node *UNUSED(node_blk))
>>   {
>> -       MSG(0, "XATTR does not support\n");
>> +       ERR_MSG("xattr is not supported\n");
>>   }
>>   #endif
>>   @@ -393,7 +393,7 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi,
>> u32 nid,
>>         u64 ofs = 0;
>>         if((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
>> -               DBG(3, "ino[0x%x] has inline data!\n", nid);
>> +               DBG(3, "ino[0x%x] has inline data\n", nid);
>>                 /* recover from inline data */
>>                 dev_write_dump(((unsigned char *)node_blk) +
>> INLINE_DATA_OFFSET,
>>                                                 0,
>> MAX_INLINE_DATA(node_blk));
>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>> index bc91839..b7baa47 100644
>> --- a/fsck/fsck.c
>> +++ b/fsck/fsck.c
>> @@ -739,12 +739,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
>> u32 nid,
>>                                 need_fix = 1;
>>                         }
>>                 }
>> -               DBG(3, "ino[0x%x] has inline data!\n", nid);
>> +               DBG(3, "ino[0x%x] has inline data\n", nid);
>>                 goto check;
>>         }
>>         if ((node_blk->i.i_inline & F2FS_INLINE_DENTRY)) {
>> -               DBG(3, "ino[0x%x] has inline dentry!\n", nid);
>> +               DBG(3, "ino[0x%x] has inline dentry\n", nid);
>>                 if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
>>                         /* should fix this bug all the time */
>>                         FIX_MSG("inline_dentry has wrong 0'th block = %x",
>> @@ -1812,28 +1812,28 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
>>                         continue;
>>                 if (!IS_VALID_BLK_ADDR(sbi, blk)) {
>> -                       MSG(0, "\tError: nat entry[ino %u block_addr
>> 0x%x]"
>> +                       ERR_MSG("nat entry[ino %u block_addr 0x%x]"
>>                                 " is in valid\n",
>>                                 ino, blk);
>>                         return -EINVAL;
>>                 }
>>                 if (!f2fs_test_sit_bitmap(sbi, blk)) {
>> -                       MSG(0, "\tError: nat entry[ino %u block_addr
>> 0x%x]"
>> +                       ERR_MSG("nat entry[ino %u block_addr 0x%x]"
>>                                 " not find it in sit_area_bitmap\n",
>>                                 ino, blk);
>>                         return -EINVAL;
>>                 }
>>                 if (!IS_VALID_NID(sbi, ino)) {
>> -                       MSG(0, "\tError: nat_entry->ino %u exceeds the
>> range"
>> +                       ERR_MSG("nat_entry->ino %u exceeds the range"
>>                                 " of nat entries %u\n",
>>                                 ino, fsck->nr_nat_entries);
>>                         return -EINVAL;
>>                 }
>>                 if (!f2fs_test_bit(ino, fsck->nat_area_bitmap)) {
>> -                       MSG(0, "\tError: nat_entry->ino %u is not set in"
>> +                       ERR_MSG("nat_entry->ino %u is not set in"
>>                                 " nat_area_bitmap\n", ino);
>>                         return -EINVAL;
>>                 }
>> @@ -1889,7 +1889,7 @@ static void fix_hard_links(struct f2fs_sb_info *sbi)
>>                 /* Sanity check */
>>                 if (sanity_check_nid(sbi, node->nid, node_blk,
>>                                         F2FS_FT_MAX, TYPE_INODE, &ni))
>> -                       FIX_MSG("Failed to fix, rerun fsck.f2fs");
>> +                       FIX_MSG("Failed to fix, please re-run fsck.f2fs");
>>                 node_blk->i.i_links = cpu_to_le32(node->actual_links);
>>   diff --git a/fsck/main.c b/fsck/main.c
>> index bbf82c3..581fc8a 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -51,7 +51,7 @@ void fsck_usage()
>>         MSG(0, "\nUsage: fsck.f2fs [options] device\n");
>>         MSG(0, "[options]:\n");
>>         MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
>> -       MSG(0, "  -d debug level [default:0]\n");
>> +       MSG(0, "  -d print debugging logs during fsck [default:0]\n");
>>         MSG(0, "  -f check/fix entire partition\n");
>>         MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
>>         MSG(0, "  -S sparse_mode\n");
>> @@ -66,7 +66,7 @@ void dump_usage()
>>   {
>>         MSG(0, "\nUsage: dump.f2fs [options] device\n");
>>         MSG(0, "[options]:\n");
>> -       MSG(0, "  -d debug level [default:0]\n");
>> +       MSG(0, "  -d print debugging logs during dump [default:0]\n");
>>         MSG(0, "  -i inode no (hex)\n");
>>         MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all
>> 0~-1]\n");
>>         MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all
>> 0~-1]\n");
>> @@ -81,7 +81,7 @@ void defrag_usage()
>>   {
>>         MSG(0, "\nUsage: defrag.f2fs [options] device\n");
>>         MSG(0, "[options]:\n");
>> -       MSG(0, "  -d debug level [default:0]\n");
>> +       MSG(0, "  -d print debugging logs during defrag [default:0]\n");
>>         MSG(0, "  -s start block address [default: main_blkaddr]\n");
>>         MSG(0, "  -S sparse_mode\n");
>>         MSG(0, "  -l length [default:512 (2MB)]\n");
>> @@ -94,7 +94,7 @@ void resize_usage()
>>   {
>>         MSG(0, "\nUsage: resize.f2fs [options] device\n");
>>         MSG(0, "[options]:\n");
>> -       MSG(0, "  -d debug level [default:0]\n");
>> +       MSG(0, "  -d print debugging logs during resize [default:0]\n");
>>         MSG(0, "  -t target sectors [default: device size]\n");
>>         exit(1);
>>   }
>> @@ -110,7 +110,7 @@ void sload_usage()
>>         MSG(0, "  -S sparse_mode\n");
>>         MSG(0, "  -t mount point [prefix of target fs path,
>> default:/]\n");
>>         MSG(0, "  -T timestamp\n");
>> -       MSG(0, "  -d debug level [default:0]\n");
>> +       MSG(0, "  -d print debugging logs during sload [default:0]\n");
>>         exit(1);
>>   }
>>   @@ -137,7 +137,7 @@ static void error_out(char *prog)
>>         else if (!strcmp("sload.f2fs", prog))
>>                 sload_usage();
>>         else
>> -               MSG(0, "\nWrong program.\n");
>> +               ERR_MSG("\nWrong program\n");
>>   }
>>     void f2fs_parse_options(int argc, char *argv[])
>> @@ -155,7 +155,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>         }
>>   #endif
>>         if (argc < 2) {
>> -               MSG(0, "\tError: Device not specified\n");
>> +               ERR_MSG("Device not specified\n");
>>                 error_out(prog);
>>         }
>>   @@ -173,11 +173,11 @@ void f2fs_parse_options(int argc, char *argv[])
>>                         switch (option) {
>>                         case 1:
>>                                 c.dry_run = 1;
>> -                               MSG(0, "Info: Dry run\n");
>> +                               INFO_MSG("Dry run\n");
>>                                 break;
>>                         case 'a':
>>                                 c.auto_fix = 1;
>> -                               MSG(0, "Info: Fix the reported
>> corruption.\n");
>> +                               INFO_MSG("Fix the reported corruption\n");
>>                                 break;
>>                         case 'p':
>>                                 /* preen mode has different levels:
>> @@ -186,7 +186,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                  */
>>                                 if (optarg[0] == '-' || !is_digits(optarg)
>> ||
>>                                                         optind == argc) {
>> -                                       MSG(0, "Info: Use default preen
>> mode\n");
>> +                                       INFO_MSG("Use the default preen
>> mode\n");
>>                                         c.preen_mode = PREEN_MODE_0;
>>                                         c.auto_fix = 1;
>>                                         optind--;
>> @@ -199,7 +199,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         c.preen_mode = PREEN_MODE_MAX - 1;
>>                                 if (c.preen_mode == PREEN_MODE_0)
>>                                         c.auto_fix = 1;
>> -                               MSG(0, "Info: Fix the reported corruption
>> in "
>> +                               INFO_MSG("Fix the reported corruption in "
>>                                         "preen mode %d\n", c.preen_mode);
>>                                 break;
>>                         case 'd':
>> @@ -211,16 +211,16 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         break;
>>                                 }
>>                                 c.dbg_lv = atoi(optarg);
>> -                               MSG(0, "Info: Debug level = %d\n",
>> c.dbg_lv);
>> +                               INFO_MSG("Debug level = %d\n", c.dbg_lv);
>>                                 break;
>>                         case 'f':
>>                         case 'y':
>>                                 c.fix_on = 1;
>> -                               MSG(0, "Info: Force to fix corruption\n");
>> +                               INFO_MSG("Force to fix corruption\n");
>>                                 break;
>>                         case 'q':
>>                                 c.preserve_limits = atoi(optarg);
>> -                               MSG(0, "Info: Preserve quota limits =
>> %d\n",
>> +                               INFO_MSG("Preserve quota limits = %d\n",
>>                                         c.preserve_limits);
>>                                 break;
>>                         case 'S':
>> @@ -231,7 +231,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                 break;
>>                         case ':':
>>                                 if (optopt == 'p') {
>> -                                       MSG(0, "Info: Use default preen
>> mode\n");
>> +                                       INFO_MSG("Use the default preen
>> mode\n");
>>                                         c.preen_mode = PREEN_MODE_0;
>>                                         c.auto_fix = 1;
>>                                 } else {
>> @@ -273,7 +273,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         break;
>>                                 }
>>                                 c.dbg_lv = atoi(optarg);
>> -                               MSG(0, "Info: Debug level = %d\n",
>> +                               INFO_MSG("Debug level = %d\n",
>>                                                         c.dbg_lv);
>>                                 break;
>>                         case 'i':
>> @@ -334,7 +334,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         break;
>>                                 }
>>                                 c.dbg_lv = atoi(optarg);
>> -                               MSG(0, "Info: Debug level = %d\n",
>> +                               INFO_MSG("Debug level = %d\n",
>>                                                         c.dbg_lv);
>>                                 break;
>>                         case 's':
>> @@ -389,7 +389,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         break;
>>                                 }
>>                                 c.dbg_lv = atoi(optarg);
>> -                               MSG(0, "Info: Debug level = %d\n",
>> +                               INFO_MSG("Debug level = %d\n",
>>                                                         c.dbg_lv);
>>                                 break;
>>                         case 't':
>> @@ -429,7 +429,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         break;
>>                                 }
>>                                 c.dbg_lv = atoi(optarg);
>> -                               MSG(0, "Info: Debug level = %d\n",
>> +                               INFO_MSG("Debug level = %d\n",
>>                                                 c.dbg_lv);
>>                                 break;
>>                         case 'f':
>> @@ -443,7 +443,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                 token = strtok(optarg, ",");
>>                                 while (token) {
>>                                         if (c.nr_opt == max_nr_opt) {
>> -                                               MSG(0, "\tError: Expected
>> at most %d selinux opts\n",
>> +                                               ERR_MSG("Expected at most
>> %d selinux opts\n",
>>
>> max_nr_opt);
>>                                                 error_out(prog);
>>                                         }
>> @@ -455,7 +455,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>                                         token = strtok(NULL, ",");
>>                                 }
>>   #else
>> -                               MSG(0, "Info: Not support selinux
>> opts\n");
>> +                               ERR_MSG("SELinux not supported\n");
>>   #endif
>>                                 break;
>>                         case 'S':
>> @@ -477,7 +477,7 @@ void f2fs_parse_options(int argc, char *argv[])
>>         }
>>         if (optind >= argc) {
>> -               MSG(0, "\tError: Device not specified\n");
>> +               ERR_MSG("Device not specified\n");
>>                 error_out(prog);
>>         }
>>   @@ -492,16 +492,16 @@ void f2fs_parse_options(int argc, char *argv[])
>>         /* print out error */
>>         switch (err) {
>>         case EWRONG_OPT:
>> -               MSG(0, "\tError: Wrong option -%c %s\n", option, optarg);
>> +               ERR_MSG("Wrong option -%c %s\n", option, optarg);
>>                 break;
>>         case ENEED_ARG:
>> -               MSG(0, "\tError: Need argument for -%c\n", option);
>> +               ERR_MSG("Need argument for -%c\n", option);
>>                 break;
>>         case EUNKNOWN_OPT:
>> -               MSG(0, "\tError: Unknown option %c\n", option);
>> +               ERR_MSG("Unknown option %c\n", option);
>>                 break;
>>         case EUNKNOWN_ARG:
>> -               MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
>> +               ERR_MSG("Unknown argument %s\n", argv[optind]);
>>                 break;
>>         }
>>         error_out(prog);
>> @@ -523,7 +523,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
>>                 case PREEN_MODE_1:
>>                         if (fsck_chk_meta(sbi)) {
>>                                 MSG(0, "[FSCK] F2FS metadata   [Fail]");
>> -                               MSG(0, "\tError: meta does not match, "
>> +                               ERR_MSG("meta does not match, "
>>                                         "force check all\n");
>>                         } else {
>>                                 MSG(0, "[FSCK] F2FS metadata   [Ok..]");
>> @@ -626,12 +626,12 @@ static int do_defrag(struct f2fs_sb_info *sbi)
>>                 goto out_range;
>>         if (c.defrag_start > c.defrag_target)
>> -               MSG(0, "Info: Move 0x%"PRIx64" <-
>> [0x%"PRIx64"-0x%"PRIx64"]\n",
>> +               INFO_MSG("Move 0x%"PRIx64" <-
>> [0x%"PRIx64"-0x%"PRIx64"]\n",
>>                                 c.defrag_target,
>>                                 c.defrag_start,
>>                                 c.defrag_start + c.defrag_len - 1);
>>         else
>> -               MSG(0, "Info: Move [0x%"PRIx64"-0x%"PRIx64"] ->
>> 0x%"PRIx64"\n",
>> +               INFO_MSG("Move [0x%"PRIx64"-0x%"PRIx64"] ->
>> 0x%"PRIx64"\n",
>>                                 c.defrag_start,
>>                                 c.defrag_start + c.defrag_len - 1,
>>                                 c.defrag_target);
>> @@ -662,7 +662,7 @@ static int do_resize(struct f2fs_sb_info *sbi)
>>         /* may different sector size */
>>         if ((c.target_sectors * c.sector_size >>
>>                         get_sb(log_blocksize)) <= get_sb(block_count)) {
>> -               ASSERT_MSG("Nothing to resize, now only support resize to
>> expand\n");
>> +               ASSERT_MSG("Nothing to resize, shrink is not
>> supported\n");
>>                 return -1;
>>         }
>>         return f2fs_resize(sbi);
>> @@ -671,7 +671,7 @@ static int do_resize(struct f2fs_sb_info *sbi)
>>   static int do_sload(struct f2fs_sb_info *sbi)
>>   {
>>         if (!c.from_dir) {
>> -               MSG(0, "Info: No source directory, but it's okay.\n");
>> +               INFO_MSG("No source directory, continuing...\n");
>>                 return 0;
>>         }
>>         if (!c.mount_point)
>> @@ -693,12 +693,13 @@ int main(int argc, char **argv)
>>                 if (errno == EBUSY)
>>                         return -1;
>>                 if (!c.ro || c.func == DEFRAG) {
>> -                       MSG(0, "\tError: Not available on mounted
>> device!\n");
>> +                       ERR_MSG("Cannot proceed on a mounted device\n");
>>                         return -1;
>>                 }
>>                 /* allow ro-mounted partition */
>> -               MSG(0, "Info: Check FS only due to RO\n");
>> +               WARN_MSG("Proceeding on a read-only mounted device\n");
>> +               WARN_MSG("Rebooting immediately after is highly
>> recommended\n");
>>                 c.fix_on = 0;
>>                 c.auto_fix = 0;
>>         }
>> @@ -715,7 +716,7 @@ fsck_again:
>>         ret = f2fs_do_mount(sbi);
>>         if (ret != 0) {
>>                 if (ret == 1) {
>> -                       MSG(0, "Info: No error was reported\n");
>> +                       INFO_MSG("No errors were reported\n");
>>                         ret = 0;
>>                 }
>>                 goto out_err;
>> @@ -756,7 +757,7 @@ fsck_again:
>>                 goto fsck_again;
>>   #endif
>>         default:
>> -               ERR_MSG("Wrong program name\n");
>> +               TRACE_ERR_MSG("Wrong program name\n");
>>                 ASSERT(0);
>>         }
>>   @@ -784,7 +785,7 @@ retry:
>>         if (ret < 0)
>>                 return ret;
>>   -     printf("\nDone.\n");
>> +       printf("\nDone\n");
>>         return 0;
>>     out_err:
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 545f862..906461f 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -64,20 +64,20 @@ void print_acl(char *value, int size)
>>         int i, count;
>>         if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION)) {
>> -               MSG(0, "Invalid ACL version [0x%x : 0x%x]\n",
>> +               ERR_MSG("Invalid ACL version [0x%x : 0x%x]\n",
>>                                 le32_to_cpu(hdr->a_version),
>> F2FS_ACL_VERSION);
>>                 return;
>>         }
>>         count = f2fs_acl_count(size);
>>         if (count <= 0) {
>> -               MSG(0, "Invalid ACL value size %d\n", size);
>> +               ERR_MSG("Invalid ACL value size %d\n", size);
>>                 return;
>>         }
>>         for (i = 0; i < count; i++) {
>>                 if ((char *)entry > end) {
>> -                       MSG(0, "Invalid ACL entries count %d\n", count);
>> +                       ERR_MSG("Invalid ACL entries count %d\n", count);
>>                         return;
>>                 }
>>   @@ -279,7 +279,7 @@ void print_node_info(struct f2fs_sb_info *sbi,
>>                 int i;
>>                 u32 *dump_blk = (u32 *)node_block;
>>                 DBG(verbose,
>> -                       "Node ID [0x%x:%u] is direct node or indirect
>> node.\n",
>> +                       "Node ID [0x%x:%u] is direct node or indirect
>> node\n",
>>                                                                 nid, nid);
>>                 for (i = 0; i <= 10; i++)
>>                         MSG(verbose, "[%d]\t\t\t[0x%8x : %d]\n",
>> @@ -404,7 +404,7 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
>>     void print_cp_state(u32 flag)
>>   {
>> -       MSG(0, "Info: checkpoint state = %x : ", flag);
>> +       INFO_MSG("checkpoint state = %x : ", flag);
>>         if (flag & CP_NOCRC_RECOVERY_FLAG)
>>                 MSG(0, "%s", " allow_nocrc");
>>         if (flag & CP_TRIMMED_FLAG)
>> @@ -435,7 +435,7 @@ void print_sb_state(struct f2fs_super_block *sb)
>>         __le32 f = sb->feature;
>>         int i;
>>   -     MSG(0, "Info: superblock features = %x : ", f);
>> +       INFO_MSG("superblock features = %x : ", f);
>>         if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
>>                 MSG(0, "%s", " encrypt");
>>         }
>> @@ -464,7 +464,7 @@ void print_sb_state(struct f2fs_super_block *sb)
>>                 MSG(0, "%s", " lost_found");
>>         }
>>         MSG(0, "\n");
>> -       MSG(0, "Info: superblock encrypt level = %d, salt = ",
>> +       INFO_MSG("superblock encrypt level = %d, salt = ",
>>                                         sb->encryption_level);
>>         for (i = 0; i < 16; i++)
>>                 MSG(0, "%02x", sb->encrypt_pw_salt[i]);
>> @@ -493,14 +493,14 @@ static inline int sanity_check_area_boundary(struct
>> f2fs_super_block *sb,
>>                                 (segment_count << log_blocks_per_seg);
>>         if (segment0_blkaddr != cp_blkaddr) {
>> -               MSG(0, "\tMismatch segment0(%u) cp_blkaddr(%u)\n",
>> +               ERR_MSG("Mismatch segment0(%u) cp_blkaddr(%u)\n",
>>                                 segment0_blkaddr, cp_blkaddr);
>>                 return -1;
>>         }
>>         if (cp_blkaddr + (segment_count_ckpt << log_blocks_per_seg) !=
>>                                                         sit_blkaddr) {
>> -               MSG(0, "\tWrong CP boundary, start(%u) end(%u)
>> blocks(%u)\n",
>> +               ERR_MSG("Wrong CP boundary, start(%u) end(%u)
>> blocks(%u)\n",
>>                         cp_blkaddr, sit_blkaddr,
>>                         segment_count_ckpt << log_blocks_per_seg);
>>                 return -1;
>> @@ -508,7 +508,7 @@ static inline int sanity_check_area_boundary(struct
>> f2fs_super_block *sb,
>>         if (sit_blkaddr + (segment_count_sit << log_blocks_per_seg) !=
>>                                                         nat_blkaddr) {
>> -               MSG(0, "\tWrong SIT boundary, start(%u) end(%u)
>> blocks(%u)\n",
>> +               ERR_MSG("Wrong SIT boundary, start(%u) end(%u)
>> blocks(%u)\n",
>>                         sit_blkaddr, nat_blkaddr,
>>                         segment_count_sit << log_blocks_per_seg);
>>                 return -1;
>> @@ -516,7 +516,7 @@ static inline int sanity_check_area_boundary(struct
>> f2fs_super_block *sb,
>>         if (nat_blkaddr + (segment_count_nat << log_blocks_per_seg) !=
>>                                                         ssa_blkaddr) {
>> -               MSG(0, "\tWrong NAT boundary, start(%u) end(%u)
>> blocks(%u)\n",
>> +               ERR_MSG("Wrong NAT boundary, start(%u) end(%u)
>> blocks(%u)\n",
>>                         nat_blkaddr, ssa_blkaddr,
>>                         segment_count_nat << log_blocks_per_seg);
>>                 return -1;
>> @@ -524,14 +524,14 @@ static inline int sanity_check_area_boundary(struct
>> f2fs_super_block *sb,
>>         if (ssa_blkaddr + (segment_count_ssa << log_blocks_per_seg) !=
>>                                                         main_blkaddr) {
>> -               MSG(0, "\tWrong SSA boundary, start(%u) end(%u)
>> blocks(%u)\n",
>> +               ERR_MSG("Wrong SSA boundary, start(%u) end(%u)
>> blocks(%u)\n",
>>                         ssa_blkaddr, main_blkaddr,
>>                         segment_count_ssa << log_blocks_per_seg);
>>                 return -1;
>>         }
>>         if (main_end_blkaddr > seg_end_blkaddr) {
>> -               MSG(0, "\tWrong MAIN_AREA, start(%u) end(%u) block(%u)\n",
>> +               ERR_MSG("Wrong MAIN_AREA, start(%u) end(%u) block(%u)\n",
>>                         main_blkaddr,
>>                         segment0_blkaddr +
>>                                 (segment_count << log_blocks_per_seg),
>> @@ -544,7 +544,7 @@ static inline int sanity_check_area_boundary(struct
>> f2fs_super_block *sb,
>>                                 segment0_blkaddr) >> log_blocks_per_seg);
>>                 err = dev_write(sb, offset, sizeof(struct
>> f2fs_super_block));
>> -               MSG(0, "Info: Fix alignment: %s, start(%u) end(%u)
>> block(%u)\n",
>> +               INFO_MSG("Fix alignment: %s, start(%u) end(%u)
>> block(%u)\n",
>>                         err ? "failed": "done",
>>                         main_blkaddr,
>>                         segment0_blkaddr +
>> @@ -589,7 +589,7 @@ int sanity_check_raw_super(struct f2fs_super_block
>> *sb, u64 offset)
>>         /* Check zoned block device feature */
>>         if (c.devices[0].zoned_model == F2FS_ZONED_HM &&
>>                         !(sb->feature &
>> cpu_to_le32(F2FS_FEATURE_BLKZONED))) {
>> -               MSG(0, "\tMissing zoned block device feature\n");
>> +               ERR_MSG("Missing zoned block device feature\n");
>>                 return -1;
>>         }
>>   @@ -634,8 +634,8 @@ int validate_super_block(struct f2fs_sb_info *sbi,
>> int block)
>>                 memcpy(c.init_version, sbi->raw_super->init_version,
>> VERSION_LEN);
>>                 get_kernel_version(c.init_version);
>>   -             MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
>> -               MSG(0, "Info: FSCK version\n  from \"%s\"\n    to
>> \"%s\"\n",
>> +               INFO_MSG("MKFS version\n  \"%s\"\n", c.init_version);
>> +               INFO_MSG("FSCK version\n  from \"%s\"\n    to \"%s\"\n",
>>                                         c.sb_version, c.version);
>>                 if (memcmp(c.sb_version, c.version, VERSION_LEN)) {
>>                         int ret;
>> @@ -655,7 +655,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int
>> block)
>>         free(sbi->raw_super);
>>         sbi->raw_super = NULL;
>> -       MSG(0, "\tCan't find a valid F2FS superblock at 0x%x\n", block);
>> +       ERR_MSG("Unable to find a valid F2FS superblock at 0x%x\n",
>> block);
>>         return -EINVAL;
>>   }
>> @@ -706,14 +706,14 @@ int init_sb_info(struct f2fs_sb_info *sbi)
>>                         c.devices[i].end_blkaddr +=
>> get_sb(segment0_blkaddr);
>>                 c.ndevs = i + 1;
>> -               MSG(0, "Info: Device[%d] : %s blkaddr =
>> %"PRIx64"--%"PRIx64"\n",
>> +               INFO_MSG("Device[%d] : %s blkaddr =
>> %"PRIx64"--%"PRIx64"\n",
>>                                 i, c.devices[i].path,
>>                                 c.devices[i].start_blkaddr,
>>                                 c.devices[i].end_blkaddr);
>>         }
>>         total_sectors = get_sb(block_count) << sbi->log_sectors_per_block;
>> -       MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
>> +       INFO_MSG("Total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
>>                                 total_sectors, total_sectors >>
>>                                                 (20 -
>> get_sb(log_sectorsize)));
>>         return 0;
>> @@ -826,7 +826,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>>         } else
>>                 goto fail_no_cp;
>>   -     MSG(0, "Info: CKPT version = %llx\n", version);
>> +       INFO_MSG("CKPT version = %llx\n", version);
>>         memcpy(sbi->ckpt, cur_page, blk_size);
>>   @@ -1024,9 +1024,9 @@ void write_nat_bits(struct f2fs_sb_info *sbi,
>>         for (i = 0; i < nat_bits_blocks; i++) {
>>                 if (dev_write_block(nat_bits + i * F2FS_BLKSIZE, blkaddr +
>> i))
>> -                       ASSERT_MSG("\tError: write NAT bits to
>> disk!!!\n");
>> +                       ASSERT_MSG("\tError: write NAT bits to disk\n");
>>         }
>> -       MSG(0, "Info: Write valid nat_bits in checkpoint\n");
>> +       INFO_MSG("Wrote valid nat_bits in checkpoint\n");
>>         free(nat_bits);
>>   }
>> @@ -1757,7 +1757,7 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info
>> *sbi)
>>                 se->valid_blocks = valid_blocks;
>>                 type = se->type;
>>                 if (type >= NO_CHECK_TYPE) {
>> -                       ASSERT_MSG("Invalide type and valid blocks=%x,%x",
>> +                       ASSERT_MSG("Invalid type and valid blocks=%x,%x",
>>                                         segno, valid_blocks);
>>                         type = 0;
>>                 }
>> @@ -2292,10 +2292,10 @@ static int check_sector_size(struct
>> f2fs_super_block *sb)
>>         set_sb(log_sectors_per_block, log_sectors_per_block);
>>         memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>> -       DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
>> +       DBG(1, "\tWriting superblock, at offset 0x%08x\n", 0);
>>         for (index = 0; index < 2; index++) {
>>                 if (dev_write(zero_buff, index * F2FS_BLKSIZE,
>> F2FS_BLKSIZE)) {
>> -                       MSG(1, "\tError: Failed while writing supe_blk "
>> +                       ERR_MSG("Failed while writing superblock "
>>                                 "on disk!!! index : %d\n", index);
>>                         free(zero_buff);
>>                         return -1;
>> @@ -2331,12 +2331,12 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>>         ret = get_valid_checkpoint(sbi);
>>         if (ret) {
>> -               ERR_MSG("Can't find valid checkpoint\n");
>> +               TRACE_ERR_MSG("Unable to find a valid checkpoint\n");
>>                 return -1;
>>         }
>>         if (sanity_check_ckpt(sbi)) {
>> -               ERR_MSG("Checkpoint is polluted\n");
>> +               TRACE_ERR_MSG("Checkpoint is polluted\n");
>>                 return -1;
>>         }
>>         cp = F2FS_CKPT(sbi);
>> @@ -2371,12 +2371,12 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>>         sbi->alloc_valid_block_count = 0;
>>         if (build_segment_manager(sbi)) {
>> -               ERR_MSG("build_segment_manager failed\n");
>> +               TRACE_ERR_MSG("build_segment_manager failed\n");
>>                 return -1;
>>         }
>>         if (build_node_manager(sbi)) {
>> -               ERR_MSG("build_node_manager failed\n");
>> +               TRACE_ERR_MSG("build_node_manager failed\n");
>>                 return -1;
>>         }
>>   @@ -2401,7 +2401,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>>                 if (*kaddr != get_cp_crc(cp))
>>                         write_nat_bits(sbi, sb, cp, sbi->cur_cp);
>>                 else
>> -                       MSG(0, "Info: Found valid nat_bits in
>> checkpoint\n");
>> +                       INFO_MSG("Found valid nat_bits in checkpoint\n");
>>                 free(kaddr);
>>         }
>>         return 0;
>> diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
>> index 5aef228..e4ce5da 100644
>> --- a/fsck/quotaio_tree.c
>> +++ b/fsck/quotaio_tree.c
>> @@ -587,7 +587,7 @@ static int check_reference(struct quota_handle *h,
>> unsigned int blk)
>>   {
>>         if (blk >= h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks) {
>>                 log_err("Illegal reference (%u >= %u) in %s quota file. "
>> -                       "Quota file is probably corrupted.\n"
>> +                       "Quota file is probably corrupted\n"
>>                         "Please run fsck (8) to fix it.",
>>                         blk,
>>                         h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks,
>> diff --git a/fsck/resize.c b/fsck/resize.c
>> index 7643511..5107dfb 100644
>> --- a/fsck/resize.c
>> +++ b/fsck/resize.c
>> @@ -149,8 +149,8 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>         if ((get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
>>                 get_sb(segment_count_main) * blks_per_seg >
>>                                                 get_sb(block_count)) {
>> -               MSG(0, "\tError: Device size is not sufficient for F2FS
>> volume, "
>> -                       "more segment needed =%u",
>> +               ERR_MSG("Device size is not sufficient for F2FS volume, "
>> +                       "more segment needed = %u",
>>                         c.new_reserved_segments -
>>                         (get_sb(segment_count_main) - 2));
>>                 return -1;
>> @@ -604,7 +604,7 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
>>         if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
>>                 err = shrink_nats(sbi, new_sb);
>>                 if (err) {
>> -                       MSG(0, "\tError: Failed to shrink NATs\n");
>> +                       ERR_MSG("Failed to shrink NATs\n");
>>                         return err;
>>                 }
>>         }
>> @@ -624,7 +624,7 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
>>                                                 new_main_blkaddr, 0);
>>                 if (!err)
>>                         offset_seg = offset >> get_sb(log_blocks_per_seg);
>> -               MSG(0, "Try to do defragement: %s\n", err ? "Skip":
>> "Done");
>> +               MSG(0, "Try to do defragement: %s\n", err ? "skip" :
>> "done");
>>         }
>>         /* move whole data region */
>>         if (err)
>> diff --git a/fsck/segment.c b/fsck/segment.c
>> index 4f8bdb4..9955a21 100644
>> --- a/fsck/segment.c
>> +++ b/fsck/segment.c
>> @@ -35,7 +35,7 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t
>> *to,
>>         blkaddr = SM_I(sbi)->main_blkaddr;
>>         if (find_next_free_block(sbi, &blkaddr, 0, type)) {
>> -               ERR_MSG("Not enough space to allocate blocks");
>> +               TRACE_ERR_MSG("Not enough space to allocate blocks");
>>                 ASSERT(0);
>>         }
>>   @@ -283,7 +283,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct
>> dentry *de)
>>         fd = open(de->full_path, O_RDONLY);
>>         if (fd < 0) {
>> -               MSG(0, "Skip: Fail to open %s\n", de->full_path);
>> +               PERR_MSG("Fail to open %s\n", de->full_path);
>>                 return -1;
>>         }
>>   diff --git a/fsck/sload.c b/fsck/sload.c
>> index 2842f2c..3481346 100644
>> --- a/fsck/sload.c
>> +++ b/fsck/sload.c
>> @@ -67,14 +67,14 @@ static int set_selinux_xattr(struct f2fs_sb_info *sbi,
>> const char *path,
>>                 return 0;
>>         if (asprintf(&mnt_path, "%s%s", c.mount_point, path) <= 0) {
>> -               ERR_MSG("cannot allocate security path for %s%s\n",
>> +               TRACE_ERR_MSG("Cannot allocate security path for %s%s\n",
>>                                                 c.mount_point, path);
>>                 return -ENOMEM;
>>         }
>>         /* set root inode selinux context */
>>         if (selabel_lookup(sehnd, &secontext, mnt_path, mode) < 0) {
>> -               ERR_MSG("cannot lookup security context for %s\n",
>> mnt_path);
>> +               TRACE_ERR_MSG("Cannot lookup security context for %s\n",
>> mnt_path);
>>                 free(mnt_path);
>>                 return -EINVAL;
>>         }
>> @@ -99,7 +99,7 @@ static int set_perms_and_caps(struct dentry *de)
>>         char *mnt_path = NULL;
>>         if (asprintf(&mnt_path, "%s%s", c.mount_point, de->path) <= 0) {
>> -               ERR_MSG("cannot allocate mount path for %s%s\n",
>> +               TRACE_ERR_MSG("Cannot allocate mount path for %s%s\n",
>>                                 c.mount_point, de->path);
>>                 return -ENOMEM;
>>         }
>> @@ -128,7 +128,8 @@ static void set_inode_metadata(struct dentry *de)
>>         ret = lstat(de->full_path, &stat);
>>         if (ret < 0) {
>> -               ERR_MSG("lstat failure\n");
>> +               PERR_MSG("lstat() failed\n");
>> +               TRACE_ERR_MSG();
>>                 ASSERT(0);
>>         }
>>   @@ -151,7 +152,7 @@ static void set_inode_metadata(struct dentry *de)
>>                 ret = readlink(de->full_path, de->link, F2FS_BLKSIZE - 1);
>>                 ASSERT(ret >= 0);
>>         } else {
>> -               ERR_MSG("unknown file type on %s", de->path);
>> +               TRACE_ERR_MSG("Unknown file type on %s", de->path);
>>                 ASSERT(0);
>>         }
>>   @@ -177,7 +178,7 @@ static int build_directory(struct f2fs_sb_info *sbi,
>> const char *full_path,
>>         entries = scandir(full_path, &namelist, filter_dot, (void
>> *)alphasort);
>>         if (entries < 0) {
>> -               ERR_MSG("No entries in %s\n", full_path);
>> +               TRACE_ERR_MSG("No entries in %s\n", full_path);
>>                 return -ENOENT;
>>         }
>>   @@ -188,7 +189,7 @@ static int build_directory(struct f2fs_sb_info *sbi,
>> const char *full_path,
>>         for (i = 0; i < entries; i++) {
>>                 dentries[i].name = (unsigned char
>> *)strdup(namelist[i]->d_name);
>>                 if (dentries[i].name == NULL) {
>> -                       ERR_MSG("Skip: ENOMEM\n");
>> +                       TRACE_ERR_MSG("Skip: ENOMEM\n");
>>                         continue;
>>                 }
>>                 dentries[i].len = strlen((char *)dentries[i].name);
>> @@ -234,7 +235,7 @@ static int build_directory(struct f2fs_sb_info *sbi,
>> const char *full_path,
>>                          * f2fs_make_symlink(sbi, dir_ino, &dentries[i]);
>>                          */
>>                 } else {
>> -                       MSG(1, "Error unknown file type\n");
>> +                       ERR_MSG("unknown file type\n");
>>                 }
>>                 ret = set_selinux_xattr(sbi, dentries[i].path,
>> @@ -259,14 +260,14 @@ static int configure_files(void)
>>   #if !defined(__ANDROID__)
>>         sehnd = selabel_open(SELABEL_CTX_FILE, c.seopt_file, c.nr_opt);
>>         if (!sehnd) {
>> -               ERR_MSG("Failed to open file contexts \"%s\"",
>> +               TRACE_ERR_MSG("Failed to open file contexts \"%s\"",
>>                                         c.seopt_file[0].value);
>>                         return -EINVAL;
>>         }
>>   #else
>>         sehnd = selinux_android_file_context_handle();
>>         if (!sehnd) {
>> -               ERR_MSG("Failed to get android file_contexts\n",
>> c.mount_point);
>> +               TRACE_ERR_MSG("Failed to get android file_contexts\n",
>> c.mount_point);
>>                 return -EINVAL;
>>         }
>>   #endif
>> @@ -278,7 +279,7 @@ skip:
>>                 int ret = load_canned_fs_config(c.fs_config_file);
>>                 if (ret < 0) {
>> -                       ERR_MSG("Failed to load fs_config \"%s\"",
>> +                       TRACE_ERR_MSG("Failed to load fs_config \"%s\"",
>>                                                 c.fs_config_file);
>>                         return ret;
>>                 }
>> @@ -296,7 +297,7 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
>>         ret = configure_files();
>>         if (ret) {
>> -               ERR_MSG("Failed to configure files\n");
>> +               TRACE_ERR_MSG("Failed to configure files\n");
>>                 return ret;
>>         }
>>   @@ -306,14 +307,14 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
>>         ret = build_directory(sbi, c.from_dir, "/",
>>                                         c.target_out_dir,
>> F2FS_ROOT_INO(sbi));
>>         if (ret) {
>> -               ERR_MSG("Failed to build due to %d\n", ret);
>> +               TRACE_ERR_MSG("Failed to build due to %d\n", ret);
>>                 return ret;
>>         }
>>         ret = set_selinux_xattr(sbi, c.mount_point,
>>                                         F2FS_ROOT_INO(sbi), S_IFDIR);
>>         if (ret) {
>> -               ERR_MSG("Failed to set selinux for root: %d\n", ret);
>> +               TRACE_ERR_MSG("Failed to set SELinux for root: %d\n",
>> ret);
>>                 return ret;
>>         }
>>   diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>> index c460050..1df7265 100644
>> --- a/include/f2fs_fs.h
>> +++ b/include/f2fs_fs.h
>> @@ -44,6 +44,9 @@
>>   #include <selinux/label.h>
>>   #endif
>>   +#include <string.h>
>> +#include <errno.h>
>> +
>>   #ifdef UNUSED
>>   #elif defined(__GNUC__)
>>   # define UNUSED(x) UNUSED_ ## x __attribute__((unused))
>> @@ -179,23 +182,46 @@ static inline uint64_t bswap_64(uint64_t val)
>>     #define ASSERT_MSG(fmt, ...)
>> \
>>         do {                                                            \
>> -               printf("[ASSERT] (%s:%4d) ", __func__, __LINE__);       \
>> -               printf(" --> "fmt"\n", ##__VA_ARGS__);                  \
>> +               fprintf(stderr, "[ASSERT] (%s:%4d) ",                   \
>> +                               __func__, __LINE__);                    \
>> +               fprintf(stderr, " --> "fmt"\n", ##__VA_ARGS__);         \
>>                 c.bug_on = 1;                                           \
>>         } while (0)
>>     #define ASSERT(exp)                                                 \
>>         do {                                                            \
>>                 if (!(exp)) {                                           \
>> -                       printf("[ASSERT] (%s:%4d) " #exp"\n",           \
>> +                       fprintf(stderr, "[ASSERT] (%s:%4d) " #exp"\n",  \
>>                                         __func__, __LINE__);            \
>>                         exit(-1);                                       \
>>                 }                                                       \
>>         } while (0)
>>   +#define TRACE_ERR_MSG(fmt, ...)
>> \
>> +       do {                                                            \
>> +               fprintf(stderr, "[%s:%d] " fmt,                         \
>> +                       __func__, __LINE__, ##__VA_ARGS__);             \
>> +       } while (0)
>> +
>> +#define PERR_MSG(fmt, ...)                                             \
>> +       do {                                                            \
>> +               fprintf(stderr, "\tError: " fmt, ##__VA_ARGS__);        \
>> +               fprintf(stderr, ": %s\n", strerror(errno));             \
>> +       } while (0)
>> +
>>   #define ERR_MSG(fmt, ...)                                             \
>>         do {                                                            \
>> -               printf("[%s:%d] " fmt, __func__, __LINE__, ##__VA_ARGS__);
>> \
>> +               fprintf(stderr, "\tError: " fmt, ##__VA_ARGS__);        \
>> +       } while (0)
>> +
>> +#define WARN_MSG(fmt, ...)                                             \
>> +       do {                                                            \
>> +               fprintf(stderr, "\tWarning: " fmt, ##__VA_ARGS__);      \
>> +       } while (0)
>> +
>> +#define INFO_MSG(fmt, ...)                                             \
>> +       do {                                                            \
>> +               printf("Info: " fmt, ##__VA_ARGS__);                    \
>>         } while (0)
>>     #define MSG(n, fmt, ...)                                            \
>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>> index 0c684d5..4fc6d06 100644
>> --- a/lib/libf2fs.c
>> +++ b/lib/libf2fs.c
>> @@ -656,7 +656,7 @@ int f2fs_dev_is_umounted(char *path)
>>   #ifdef __linux__
>>         ret = is_mounted("/proc/mounts", path);
>>         if (ret) {
>> -               MSG(0, "Info: Mounted device!\n");
>> +               ERR_MSG("Cannot proceed on a mounted device\n");
>>                 return -1;
>>         }
>>   #endif
>> @@ -666,7 +666,7 @@ int f2fs_dev_is_umounted(char *path)
>>   #endif
>>         ret = is_mounted(MOUNTED, path);
>>         if (ret) {
>> -               MSG(0, "Info: Mounted device!\n");
>> +               ERR_MSG("Cannot proceed on a mounted device\n");
>>                 return -1;
>>         }
>>   #endif
>> @@ -679,7 +679,7 @@ int f2fs_dev_is_umounted(char *path)
>>   #ifdef __linux__
>>                 ret = is_mounted("/proc/mounts", "/dev/root");
>>                 if (ret) {
>> -                       MSG(0, "Info: Mounted device!\n");
>> +                       ERR_MSG("Cannot proceed on a mounted device\n");
>>                         return -1;
>>                 }
>>   #endif
>> @@ -695,7 +695,7 @@ int f2fs_dev_is_umounted(char *path)
>>                 if (fd >= 0) {
>>                         close(fd);
>>                 } else if (errno == EBUSY) {
>> -                       MSG(0, "\tError: In use by the system!\n");
>> +                       ERR_MSG("Cannot proceed on a device currently in
>> use\n");
>>                         return -1;
>>                 }
>>         }
>> @@ -767,7 +767,7 @@ int get_device_info(int i)
>>                 fd = open((char *)dev->path, O_RDWR);
>>         }
>>         if (fd < 0) {
>> -               MSG(0, "\tError: Failed to open the device!\n");
>> +               PERR_MSG("Failed to open the device");
>>                 return -1;
>>         }
>>   @@ -781,13 +781,13 @@ int get_device_info(int i)
>>         if (c.kd == -1) {
>>                 c.kd = open("/proc/version", O_RDONLY);
>>                 if (c.kd < 0) {
>> -                       MSG(0, "\tInfo: No support kernel version!\n");
>> +                       WARN_MSG("Cannot resolve kernel version");
>>                         c.kd = -2;
>>                 }
>>         }
>>         if (fstat(fd, &stat_buf) < 0 ) {
>> -               MSG(0, "\tError: Failed to get the device stat!\n");
>> +               ERR_MSG("Failed to get the device stat\n");
>>                 return -1;
>>         }
>>   @@ -798,18 +798,18 @@ int get_device_info(int i)
>>         } else if (S_ISBLK(stat_buf.st_mode)) {
>>   #ifdef BLKSSZGET
>>                 if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
>> -                       MSG(0, "\tError: Using the default sector
>> size\n");
>> +                       ERR_MSG("Using the default sector size\n");
>>                 else if (dev->sector_size < sector_size)
>>                         dev->sector_size = sector_size;
>>   #endif
>>   #ifdef BLKGETSIZE64
>>                 if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
