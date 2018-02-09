From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 4/5] mkfs.f2fs: create lost+found
 directory
Date: Fri, 9 Feb 2018 11:21:26 +0800
Message-ID: <9eb99d32-5e33-d7ad-d8f6-a1ad3d721086@huawei.com>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-5-shengyong1@huawei.com>
 <dfbb59fc-d2c7-09d6-960c-8f3fc8163081@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ejzG6-0000B1-Sb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:21:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejzG4-00039n-5b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:21:54 +0000
In-Reply-To: <dfbb59fc-d2c7-09d6-960c-8f3fc8163081@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

On 2018/2/8 23:08, Chao Yu wrote:
> On 2018/2/6 12:31, Sheng Yong wrote:
>> This patch introduces a new feature F2FS_FEATURE_LOST_FOUND. It can be
>> switched on by indicating a new option `lost+found' with -O. If
> 
> Not sure, do we need to change this option to 'lost_found' to follow other
> generic -O options?

I'm also not sure about this, since there is already a `lost_found' in fsck :(

> 
>> F2FS_FEATUER_LOST_FOUND is enabled, an empty directory lost+found is
>> created during mkfs.
>>
>> This is a preparation for fsck. During fsck, the directory is used to
>> save unreachable files, which have no parent directory or their parent
>> directory is removed by fsck. Encrypted files are also allowed to be
>> saved here.
>>
[...]
>> +static int f2fs_write_lpf_inode(void)
>> +{
>> +	struct f2fs_node *raw_node;
>> +	u_int64_t blk_size_bytes, data_blk_nor;
>> +	u_int64_t main_area_node_seg_blk_offset;
>> +	int err = 0;
>> +
>> +	ASSERT(c.lpf_ino);
>> +
>> +	raw_node = calloc(F2FS_BLKSIZE, 1);
>> +	if (raw_node == NULL) {
>> +		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
>> +		return -1;
>> +	}
>> +
>> +	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
>> +	raw_node->footer.ino = raw_node->footer.nid;
>> +	raw_node->footer.cp_ver = cpu_to_le64(1);
>> +	raw_node->footer.next_blkaddr = cpu_to_le32(
>> +			get_sb(main_blkaddr) +
>> +			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
>> +			1 + c.quota_inum + 1);
>> +
>> +	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
>> +	raw_node->i.i_links = cpu_to_le32(2);
>> +	raw_node->i.i_uid = cpu_to_le32(getuid());
>> +	raw_node->i.i_gid = cpu_to_le32(getgid());
>> +
>> +	blk_size_bytes = 1 << get_sb(log_blocksize);
>> +	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
>> +	raw_node->i.i_blocks = cpu_to_le64(2);
>> +
>> +	raw_node->i.i_atime = cpu_to_le32(time(NULL));
>> +	raw_node->i.i_atime_nsec = 0;
>> +	raw_node->i.i_ctime = cpu_to_le32(time(NULL));
>> +	raw_node->i.i_ctime_nsec = 0;
>> +	raw_node->i.i_mtime = cpu_to_le32(time(NULL));
>> +	raw_node->i.i_mtime_nsec = 0;
>> +	raw_node->i.i_generation = 0;
>> +	raw_node->i.i_xattr_nid = 0;
>> +	raw_node->i.i_flags = 0;
>> +	raw_node->i.i_pino = le32_to_cpu(sb->root_ino);
>> +	raw_node->i.i_namelen = le32_to_cpu(strlen(LPF));
>> +	memcpy(raw_node->i.i_name, LPF, strlen(LPF));
>> +	raw_node->i.i_current_depth = cpu_to_le32(1);
>> +	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
>> +
>> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
>> +		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
>> +		raw_node->i.i_extra_isize =
>> +			cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
>> +	}
>> +
>> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
>> +		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
> 
> Need to handle inode_crtime case?

Right, thanks.
> 
>> +
>> +	data_blk_nor = f2fs_add_default_dentry_lpf();
>> +	if (data_blk_nor < 0) {
>> +		MSG(1, "\tError: Failed to add default dentries for lost+found!!!\n");
>> +		err = -1;
>> +		goto exit;
>> +	}
>> +	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);
>> +
>> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
>> +		raw_node->i.i_inode_checksum =
>> +			cpu_to_le32(f2fs_inode_chksum(raw_node));
>> +
>> +	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
>> +	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
>> +		c.blks_per_seg + c.quota_inum + 1;
>> +
>> +	DBG(1, "\tWriting lost+found inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n",
>> +			get_sb(main_blkaddr),
>> +			c.cur_seg[CURSEG_HOT_NODE],
>> +			c.blks_per_seg, main_area_node_seg_blk_offset);
>> +	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
>> +		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
>> +		err = -1;
>> +		goto exit;
>> +	}
>> +
>> +	c.lpf_inum++;
>> +exit:
>> +	free(raw_node);
>> +	return err;
>> +}
>> +
>>   static int f2fs_add_default_dentry_root(void)
>>   {
>>   	struct f2fs_dentry_block *dent_blk = NULL;
>> @@ -1326,6 +1495,27 @@ static int f2fs_add_default_dentry_root(void)
>>   	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
>>   	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
>>   
>> +	if (c.lpf_ino) {
>> +		int len = strlen(LPF);
>> +		f2fs_hash_t hash = f2fs_dentry_hash((unsigned char *)LPF, len);
>> +
>> +		dent_blk->dentry[2].hash_code = cpu_to_le32(hash);
>> +		dent_blk->dentry[2].ino = cpu_to_le32(c.lpf_ino);
>> +		dent_blk->dentry[2].name_len = strlen(LPF);
> 
> cpu_to_le16(strlen(LPF))

Will re-check all endianness problems :)
> 
>> +		dent_blk->dentry[2].file_type = F2FS_FT_DIR;
>> +		memcpy(dent_blk->filename[2], LPF, F2FS_SLOT_LEN);
>> +
>> +		dent_blk->dentry[3].hash_code = cpu_to_le32(hash);
>> +		dent_blk->dentry[3].ino = cpu_to_le32(c.lpf_ino);
>> +		dent_blk->dentry[3].name_len = strlen(LPF);
>> +		dent_blk->dentry[3].file_type = F2FS_FT_DIR;
> 
> Do not need to update this whole slot?

What do you mean by updating the whole slot? Two slots used by "lost+found"
are filled.

thanks,
Sheng
> 
>> +		memcpy(dent_blk->filename[3], LPF + F2FS_SLOT_LEN,
>> +				len - F2FS_SLOT_LEN);
>> +
>> +		test_and_set_bit_le(2, dent_blk->dentry_bitmap);
>> +		test_and_set_bit_le(3, dent_blk->dentry_bitmap);
>> +	}
>> +
>>   	data_blk_offset = get_sb(main_blkaddr);
>>   	data_blk_offset += c.cur_seg[CURSEG_HOT_DATA] *
>>   				c.blks_per_seg;
>> @@ -1363,6 +1553,14 @@ static int f2fs_create_root_dir(void)
>>   		}
>>   	}
>>   
>> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
>> +		err = f2fs_write_lpf_inode();
>> +		if (err < 0) {
>> +			MSG(1, "\tError: Failed to write lost+found inode!!!\n");
>> +			goto exit;
>> +		}
>> +	}
>> +
>>   	err = f2fs_update_nat_root();
>>   	if (err < 0) {
>>   		MSG(1, "\tError: Failed to update NAT for root!!!\n");
>> @@ -1428,6 +1626,7 @@ int f2fs_format_device(void)
>>   		MSG(0, "\tError: Failed to write the Super Block!!!\n");
>>   		goto exit;
>>   	}
>> +
> 
> Meaningless blank?
> 
> Thanks,
> 
>>   exit:
>>   	if (err)
>>   		MSG(0, "\tError: Could not format the device!!!\n");
>> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
>> index 120eeba..6382e71 100644
>> --- a/mkfs/f2fs_format_main.c
>> +++ b/mkfs/f2fs_format_main.c
>> @@ -95,6 +95,8 @@ static void parse_feature(const char *features)
>>   		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
>>   	} else if (!strcmp(features, "inode_crtime")) {
>>   		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CRTIME);
>> +	} else if (!strcmp(features, "lost+found")) {
>> +		c.feature |= cpu_to_le32(F2FS_FEATURE_LOST_FOUND);
>>   	} else {
>>   		MSG(0, "Error: Wrong features\n");
>>   		mkfs_usage();
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
