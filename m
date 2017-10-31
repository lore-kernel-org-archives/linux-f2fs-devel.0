From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 3/8] dump/fsck: introduce
 print_xattr_entry
Date: Tue, 31 Oct 2017 17:02:25 +0800
Message-ID: <7a8efa8b-c8ae-c2fa-3ed4-698d599a41c1@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-3-shengyong1@huawei.com>
 <6c6f032f-51f1-5ce1-ae23-48c72f4588cf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1e9SUL-000394-Uo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 09:05:37 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e9SUK-0003XM-5i
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 09:05:37 +0000
In-Reply-To: <6c6f032f-51f1-5ce1-ae23-48c72f4588cf@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net



On 2017/10/31 15:51, Chao Yu wrote:
> On 2017/10/31 9:38, Sheng Yong wrote:
[...]
>> +
>> +void print_xattr_entry(struct f2fs_xattr_entry *ent)
>> +{
>> +	char *value = (char *)(ent->e_name + le16_to_cpu(ent->e_name_len));
>> +	struct fscrypt_context *ctx;
>> +	int i;
>> +
>> +	MSG(0, "\nxattr: e_name_index:%d e_name:", ent->e_name_index);
>> +	for (i = 0; i < le16_to_cpu(ent->e_name_len); i++)
>> +		MSG(0, "%c", ent->e_name[i]);
>> +	MSG(0, " e_name_len:%d e_value_size:%d e_value:\n",
>> +			ent->e_name_len, le16_to_cpu(ent->e_value_size));
>> +
>> +	switch (ent->e_name_index) {
>> +	case F2FS_XATTR_INDEX_USER:
>> +	case F2FS_XATTR_INDEX_SECURITY:
>> +		for (i = 0; i < le16_to_cpu(ent->e_value_size); i++)
>> +			MSG(0, "%c", value[i]);
> 
> It could be unreadable if user stores pure value in xattr entry.
Actually, I'm not quite sure about the value of each type of xattr. But does
USER xattr contain only plain text?

thanks,
Sheng
> 
> Thanks,
> 
>> +		MSG(0, "\n");
>> +		break;
>> +	case F2FS_XATTR_INDEX_POSIX_ACL_ACCESS:
>> +	case F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT:
>> +		print_acl(value, le16_to_cpu(ent->e_value_size));
>> +		break;
>> +	case F2FS_XATTR_INDEX_TRUSTED:
>> +	case F2FS_XATTR_INDEX_LUSTRE:
>> +		for (i = 0; i < le16_to_cpu(ent->e_value_size); i++)
>> +			MSG(0, "%02X", value[i]);
>> +		MSG(0, "\n");
>> +		break;
>> +	case F2FS_XATTR_INDEX_ENCRYPTION:
>> +		ctx = (struct fscrypt_context *)value;
>> +		MSG(0, "format: %d\n", ctx->format);
>> +		MSG(0, "contents_encryption_mode: 0x%x\n", ctx->contents_encryption_mode);
>> +		MSG(0, "filenames_encryption_mode: 0x%x\n", ctx->filenames_encryption_mode);
>> +		MSG(0, "flags: 0x%x\n", ctx->flags);
>> +		MSG(0, "master_key_descriptor: ");
>> +		for (i = 0; i < FS_KEY_DESCRIPTOR_SIZE; i++)
>> +			MSG(0, "%02X", ctx->master_key_descriptor[i]);
>> +		MSG(0, "\nnonce: ");
>> +		for (i = 0; i < FS_KEY_DERIVATION_NONCE_SIZE; i++)
>> +			MSG(0, "%02X", ctx->nonce[i]);
>> +		MSG(0, "\n");
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +void print_inode_info(struct f2fs_sb_info *sbi,
>> +			struct f2fs_node *node, int name)
>> +{
>> +	struct f2fs_inode *inode = &node->i;
>> +	void *xattr_addr;
>> +	struct f2fs_xattr_entry *ent;
>>   	unsigned char en[F2FS_NAME_LEN + 1];
>>   	unsigned int i = 0;
>>   	int namelen = le32_to_cpu(inode->i_namelen);
>> @@ -111,17 +225,24 @@ void print_inode_info(struct f2fs_inode *inode, int name)
>>   	DISP_u32(inode, i_nid[3]);	/* indirect */
>>   	DISP_u32(inode, i_nid[4]);	/* double indirect */
>>   
>> +	xattr_addr = read_all_xattrs(sbi, node);
>> +	list_for_each_xattr(ent, xattr_addr) {
>> +		print_xattr_entry(ent);
>> +	}
>> +	free(xattr_addr);
>> +
>>   	printf("\n");
>>   }
>>   
>> -void print_node_info(struct f2fs_node *node_block, int verbose)
>> +void print_node_info(struct f2fs_sb_info *sbi,
>> +			struct f2fs_node *node_block, int verbose)
>>   {
>>   	nid_t ino = le32_to_cpu(node_block->footer.ino);
>>   	nid_t nid = le32_to_cpu(node_block->footer.nid);
>>   	/* Is this inode? */
>>   	if (ino == nid) {
>>   		DBG(verbose, "Node ID [0x%x:%u] is inode\n", nid, nid);
>> -		print_inode_info(&node_block->i, verbose);
>> +		print_inode_info(sbi, node_block, verbose);
>>   	} else {
>>   		int i;
>>   		u32 *dump_blk = (u32 *)node_block;
>> diff --git a/fsck/xattr.c b/fsck/xattr.c
>> index 3f5c7d3..1d0f7d3 100644
>> --- a/fsck/xattr.c
>> +++ b/fsck/xattr.c
>> @@ -20,7 +20,7 @@
>>   #define XATTR_CREATE 0x1
>>   #define XATTR_REPLACE 0x2
>>   
>> -static void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
>> +void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
>>   {
>>   	struct f2fs_xattr_header *header;
>>   	void *txattr_addr;
>> diff --git a/fsck/xattr.h b/fsck/xattr.h
>> index b414629..beed3bb 100644
>> --- a/fsck/xattr.h
>> +++ b/fsck/xattr.h
>> @@ -31,10 +31,62 @@ struct f2fs_xattr_entry {
>>   	char e_name[0];		/* attribute name */
>>   };
>>   
>> +#define FS_KEY_DESCRIPTOR_SIZE 8
>> +#define FS_KEY_DERIVATION_NONCE_SIZE 16
>> +
>> +struct fscrypt_context {
>> +	u8 format;
>> +	u8 contents_encryption_mode;
>> +	u8 filenames_encryption_mode;
>> +	u8 flags;
>> +	u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
>> +	u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
>> +} __attribute__((packed));
>> +
>> +#define F2FS_ACL_VERSION	0x0001
>> +
>> +struct f2fs_acl_entry {
>> +	__le16 e_tag;
>> +	__le16 e_perm;
>> +	__le32 e_id;
>> +};
>> +
>> +struct f2fs_acl_entry_short {
>> +	__le16 e_tag;
>> +	__le16 e_perm;
>> +};
>> +
>> +struct f2fs_acl_header {
>> +	__le32 a_version;
>> +};
>> +
>> +static inline int f2fs_acl_count(int size)
>> +{
>> +	ssize_t s;
>> +	size -= sizeof(struct f2fs_acl_header);
>> +	s = size - 4 * sizeof(struct f2fs_acl_entry_short);
>> +	if (s < 0) {
>> +		if (size % sizeof(struct f2fs_acl_entry_short))
>> +			return -1;
>> +		return size / sizeof(struct f2fs_acl_entry_short);
>> +	} else {
>> +		if (s % sizeof(struct f2fs_acl_entry))
>> +			return -1;
>> +		return s / sizeof(struct f2fs_acl_entry) + 4;
>> +	}
>> +}
>> +
>>   #define XATTR_ROUND	(3)
>>   
>>   #define XATTR_SELINUX_SUFFIX "selinux"
>> -#define F2FS_XATTR_INDEX_SECURITY	6
>> +#define F2FS_XATTR_INDEX_USER			1
>> +#define F2FS_XATTR_INDEX_POSIX_ACL_ACCESS	2
>> +#define F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT	3
>> +#define F2FS_XATTR_INDEX_TRUSTED		4
>> +#define F2FS_XATTR_INDEX_LUSTRE			5
>> +#define F2FS_XATTR_INDEX_SECURITY		6
>> +#define F2FS_XATTR_INDEX_ENCRYPTION		9
>> +
>>   #define IS_XATTR_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
>>   
>>   #define XATTR_HDR(ptr)		((struct f2fs_xattr_header *)(ptr))
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
